# User
class User
  attr_accessor :company
  attr_reader :id, :first_name, :last_name, :email,
              :company_id, :email_status, :active_status, :tokens

  def initialize(params)
    @id = params.fetch(:id, nil)
    @first_name = params.fetch(:first_name, nil)
    @last_name = params.fetch(:last_name, nil)
    @email = params.fetch(:email, nil)
    @company_id = params.fetch(:company_id, nil)
    @email_status = params.fetch(:email_status, nil)
    @active_status = params.fetch(:active_status, nil)
    @tokens = params.fetch(:tokens, nil)
    @token_history = [@tokens]
  end

  def add_tokens(amount)
    @tokens += amount
    @token_history.prepend(amount)
  end

  def should_email?
    @company.email_status && @email_status
  end

  def balance
    @tokens
  end

  def previous_balance
    @token_history.last
  end
end
