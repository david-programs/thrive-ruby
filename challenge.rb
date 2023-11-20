require 'json'
require_relative './models/company'
require_relative './utils/file_parser'
require_relative './utils/file_output'
require_relative './services/reference_builder'
require_relative './services/user_service'

# Parse JSON files into Company and Users
company_by_id = FileParser.company_by_id('./input/companies.json')
users = FileParser.users('./input/users.json')

# Initialize references between Company and Users
ReferenceBuilder.build_references(users, company_by_id)

# Perform the top up logic
UserService.top_up_users(users)

# Print results into output file
FileOutput.create_output_file(company_by_id.values)
