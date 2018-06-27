module Unhookd
  class Configuration
    attr_accessor :unhookd_url, :repo_name, :chart_name

    def initialize
      @unhookd_url = 'http://localhost:8080' # The url that Unhookd exposes
      @repo_name   = 'repo_name'             # The Git repository name of the project
      @chart_name  = 'repo/chart'            # The Charts repository and name for Unhookd to deploy
    end
  end
end
