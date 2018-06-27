module Unhookd
  class Configuration
    attr_accessor :unhookd_url

    def initialize
      @unhookd_url = 'http://localhost:8080'
    end
  end
end
