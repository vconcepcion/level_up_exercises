class Bomb
  attr_reader :status

  ALLOWED_ATTEMPTS = 3

  def initialize(activation_code: '1234', deactivation_code: '0000')
    @activation_code    = activation_code
    @deactivation_code  = deactivation_code
    @num_attempts       = 0
  end

  def enter_code(code)
    raise "Not in service!!" unless in_service?
    @num_attempts += 1 if active?
    if @num_attempts >= ALLOWED_ATTEMPTS
      explode
    else
      process_attempt(code)
    end
  end

  def active?
    @status == :active
  end

  def inactive?
    !active?
  end

  def in_service?
    @status != :not_in_service
  end

  private

  def activate
    @status = :active
  end

  def deactivate
    @status = :inactive
    @num_attempts = 0
  end

  def explode
    @status = :not_in_service
  end

  def process_attempt(code)
    raise "Code must be numeric." unless valid_code?(code)
    case code
    when @activation_code
      activate
    when @deactivation_code
      deactivate
    end
  end

  def valid_code?(code)
    !!(/^\d+$/ =~ code)
  end
end
