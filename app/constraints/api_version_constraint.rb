class ApiVersionConstraint
  attr_reader :version

  def initialize(options)
    @version = options.fetch(:version)
  end

  def matches?(request)
    request.headers.fetch(:accept).include?("application/vnd.nexu-backend-api.v#{version}+json")
  end
end
