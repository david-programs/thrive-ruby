require 'optparse'
require 'json'
require_relative './models/company'
require_relative './utils/file_parser'
require_relative './utils/file_output'
require_relative './services/reference_builder'
require_relative './services/user_service'

# Accept optional command line arguments
file_paths = OpenStruct.new
file_paths.users_path = './input/users.json'
file_paths.companies_path = './input/companies.json'
file_paths.output_path = './output/output.txt'
OptionParser.new do |opts|
  opts.banner = 'Usage: challenge.rb [options]'

  opts.on('-u', '--users [USERS]', 'Users json file path') do |users_path|
    file_paths.users_path = users_path
  end

  opts.on('-c', '--companies [COMPANIES]', 'Companies json file path') do |companies_path|
    file_paths.companies_path = companies_path
  end

  opts.on('-o', '--output [OUTPUT]', 'Output file path') do |output_path|
    file_paths.output_path = output_path
  end
end.parse!

puts "Using users from: #{file_paths.users_path}"
puts "Using companies from: #{file_paths.companies_path}"
puts "Outputting results to: #{file_paths.output_path}"

# Parse JSON files into Company and Users models
company_by_id = FileParser.company_by_id(file_paths.companies_path)
users = FileParser.users(file_paths.users_path)

# Initialize references between Company and Users
ReferenceBuilder.build_references(users, company_by_id)

# Perform the top up logic
UserService.top_up_users(users)

# Print results into output file
FileOutput.create_output_file(company_by_id.values, file_paths.output_path)
