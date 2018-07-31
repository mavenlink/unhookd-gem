class HttpFactory
  include HTTParty

  logger Unhookd.configuration.logger
end
