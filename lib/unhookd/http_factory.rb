#

require 'httparty'

module Unhookd
  class HttpFactory
    include HTTParty

    logger ::Unhookd.configuration.logger

    read_timeout ::Unhookd.configuration.read_timeout
  end
end
