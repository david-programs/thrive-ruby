class UserService
  def self.top_up_users(users)
    users.filter(&:active_status).each do |user|
      amount = user.company.top_up

      user.add_tokens(amount)
      user.company.add_to_recent_top_ups(amount)
    end
  end
end
