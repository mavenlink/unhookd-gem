#

require 'httparty'

module Unhookd
  class HttpFactory
    include HTTParty

    logger ::Unhookd.configuration.logger
  end
end
