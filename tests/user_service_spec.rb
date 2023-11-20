require 'minitest/autorun'
require_relative '../models/user'
require_relative '../models/company'
require_relative '../services/user_service'
require_relative '../services/reference_builder'

class UserServiceTest < Minitest::Test
  def setup
    @company = Company.new({ id: 1, name: "Bob's Company", top_up: 10, email_status: false })
    @user_one = User.new({ id: 1, first_name: 'Bob', last_name: 'Burgers', email: 'test@example.com', company_id: 1,
                           email_status: true, active_status: true, tokens: 100 })
    @user_two = User.new({ id: 2, first_name: 'Assistant', last_name: 'To Bob', email: 'test@example.com', company_id: 1,
                           email_status: true, active_status: true, tokens: 0 })
    ReferenceBuilder.build_references([@user_one, @user_two], { 1 => @company })
  end

  def test_top_up_user_increases_tokens_for_single_user
    UserService.top_up_users([@user_one])

    assert_equal @user_one.tokens, 110
  end

  def test_top_up_users_increases_tokens_for_multiple_users
    UserService.top_up_users([@user_one, @user_two])

    assert_equal @user_one.tokens, 110
    assert_equal @user_two.tokens, 10
  end
end
