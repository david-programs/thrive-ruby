module FileOutput
  def self.create_output_file(companies, output_path)
    companies = companies.sort_by(&:id)

    File.open(output_path, 'w') do |file|
      companies.each do |company|
        next if company.active_users.empty?

        users = company.active_users.sort_by(&:last_name)

        users_to_email, users_to_not_email = users.partition(&:should_email?)

        file.puts "\tCompany Id: #{company.id}"
        file.puts "\tCompany Name: #{company.name}"
        file.puts "\tUsers Emailed:\n"
        users_to_email.each { |user_to_email| output_user_information(user_to_email, file) }
        file.puts "\tUsers Not Emailed:\n"
        users_to_not_email.each { |user_to_not_email| output_user_information(user_to_not_email, file) }
        file.puts "\t\tTotal amount of top ups for #{company.name}: #{company.recent_top_ups}"
        file.puts
      end
    end
  end

  def self.output_user_information(user, file)
    file.puts "\t\t#{user.last_name}, #{user.first_name}, #{user.email}"
    file.puts "\t\t  Previous Token Balance, #{user.previous_balance}"
    file.puts "\t\t  New Token Balance #{user.balance}"
  end
end
