class BaseCustomException < StandardError
  attr_reader :msg, :code

  def initialize(msg, code)
    @msg = msg
    @code = code
  end

  def message
    { message: msg, code: code }
  end
end
