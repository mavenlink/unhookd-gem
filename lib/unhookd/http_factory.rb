class HttpFactory
  include HTTParty

  logger ::Logger.new Unhookd.configuration.logger
end
