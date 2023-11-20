require 'minitest/autorun'
require_relative '../models/user'
require_relative '../models/company'
require_relative '../services/user_service'
require_relative '../services/reference_builder'

class ReferenceBuilderTest < Minitest::Test
  def setup
    @company = Company.new({ id: 1, name: "Bob's Company", top_up: 10, email_status: false })
    @user_one = User.new({ id: 1, first_name: 'Bob', last_name: 'Burgers', email: 'test@example.com', company_id: 1,
                           email_status: true, active_status: true, tokens: 100 })
    @user_two = User.new({ id: 2, first_name: 'Assistant', last_name: 'To Bob', email: 'test@example.com', company_id: 1,
                           email_status: true, active_status: true, tokens: 0 })

  end

  def test_build_references_links_user_to_company
    users = [@user_one]

    ReferenceBuilder.build_references(users, { 1 => @company })

    assert_equal @user_one.company, @company
  end

  def test_build_references_company_to_users
    users = [@user_one, @user_two]

    ReferenceBuilder.build_references(users, { 1 => @company })

    assert_equal @company.users, users
  end
end
