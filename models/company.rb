# Company
class Company
  attr_reader :id, :name, :top_up, :email_status, :companies, :users
  attr_accessor :recent_top_ups

  def initialize(params)
    @id = params.fetch(:id, nil)
    @name = params.fetch(:name, nil)
    @top_up = params.fetch(:top_up, nil)
    @email_status = params.fetch(:email_status, nil)
    @users = []
    @recent_top_ups = 0
  end

  def add_user(user)
    @users.append(user)
  end

  def add_to_recent_top_ups(amount)
    @recent_top_ups += amount
  end

  def active_users
    @users.filter(&:active_status)
  end
end
