#

require 'httparty'

module Unhookd
  class HttpFactory
    include HTTParty

    logger ::Unhookd.configuration.logger

    read_timeout 120
  end
end
