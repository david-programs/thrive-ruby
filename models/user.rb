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

    validate
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

  def validate
    raise 'Missing id for company' if @id.nil?
    raise 'Missing first_name for company' if @first_name.nil? || @first_name.empty?
    raise 'Missing last_name for company' if @last_name.nil? || @last_name.empty?
    raise 'Missing email for company' if @email.nil? || @email.empty?
    raise 'Missing company_id for company' if @company_id.nil?
    raise 'Missing email_status for company' if @email_status.nil?
    raise 'Missing active_status for company' if @active_status.nil?
    raise 'Missing tokens for company' if @tokens.nil?
  end
end
