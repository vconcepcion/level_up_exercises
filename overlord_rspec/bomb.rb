class Bomb
  attr_reader :status, :attempts_remaining

  MAX_ALLOWED_ATTEMPTS = 3

  def initialize(options = {})
    activation_code     = options.fetch(:activation_code, '1234')
    deactivation_code   = options.fetch(:deactivation_code, '0000')
    @activation_code    = validate_code(activation_code)
    @deactivation_code  = validate_code(deactivation_code)
    reset
  end

  def enter_code(code)
    raise OutOfServiceError if out_of_service?
    @attempts_remaining -= 1 if active?
    if @attempts_remaining <= 0
      explode
    else
      process_attempt(code)
    end
  end

  def active?
    @status == :active
  end

  def inactive?
    @status == :inactive
  end

  def out_of_service?
    @status == :out_of_service
  end

  private

  def process_attempt(code)
    case validate_code(code)
    when @activation_code
      activate
    when @deactivation_code
      deactivate
    end
  end

  def activate
    @status = :active
  end

  def deactivate
    @status = :inactive
    @attempts_remaining = MAX_ALLOWED_ATTEMPTS
  end
  alias_method :reset, :deactivate

  def explode
    @status = :out_of_service
  end

  def validate_code(code)
    code.tap do |c|
      c.gsub!(/\s/, '')
      raise InvalidInputError, "Code '#{c}' must only include numeric characters." unless !!(/^\d+$/ =~ c)
    end
  end
end

class InvalidInputError < StandardError; end
class OutOfServiceError < RuntimeError; end
