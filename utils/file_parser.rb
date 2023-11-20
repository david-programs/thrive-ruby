require_relative '../models/company'
require_relative '../models/user'
require 'set'

# Reads JSON files and converts them into models. References between models aren't formed until ReferenceBuilder is invoked.

module FileParser
  def self.company_by_id(file_path)
    company_by_id = File.read(file_path)

    data_hash = JSON.parse(company_by_id)

    company_by_id = {}

    data_hash.each do |company_json|
      company_by_id[company_json['id']] =
        Company.new(
          {
            id: company_json['id'],
            name: company_json['name'],
            top_up: company_json['top_up'],
            email_status: company_json['email_status']
          }
        )
    end

    company_by_id
  end

  def self.users(file_path)
    users_file = File.read(file_path)

    data_hash = JSON.parse(users_file)

    users = []

    user_ids = Set.new
    data_hash.each do |user_json|
      user_id = user_json['id']
      if user_ids.include?(user_id)
        puts "WARNING duplicate id detected: #{user_id}. Please ensure data is correct."
        puts 'Proceeding with multiple users with same id.'
      else
        user_ids.add(user_id)
      end

      users.append(
        User.new(
          {
            id: user_id,
            first_name: user_json['first_name'],
            last_name: user_json['last_name'],
            email: user_json['email'],
            company_id: user_json['company_id'],
            email_status: user_json['email_status'],
            active_status: user_json['active_status'],
            tokens: user_json['tokens']
          }
        )
      )
    end

    users
  end
end
