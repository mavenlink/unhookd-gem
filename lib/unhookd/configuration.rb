module Unhookd
  class Configuration
    attr_accessor :unhookd_url, :repo_name, :chart_name, :slack_webhook_url

    def initialize
      @unhookd_url       = 'http://localhost:8080' # (required) The url that Unhookd exposes
      @repo_name         = 'repo_name'             # (required) The Git repository name of the project
      @chart_name        = 'repo/chart'            # (required) The Charts repository and name for Unhookd to deploy
      @slack_webhook_url = nil                     # (optional) A Slack Webhook URl to send a post-deploy notification to
    end
  end
end
