module Unhookd
  class Configuration
    attr_accessor :unhookd_url, :chart_name, :slack_webhook_url, :slack_webhook_message, :values_file_path

    def initialize
      @unhookd_url           = 'http://localhost:8080' # (required) The url that Unhookd exposes
      @chart_name            = 'repo/chart'            # (required) The Charts repository and name for Unhookd to deploy
      @slack_webhook_url     = nil                     # (optional) A Slack Webhook URl to send a post-deploy notification to
      @slack_webhook_message = nil                     # (optional) A Slack Webhook Message to send with the post-deploy notification
      @values_file_path      = nil                     # (optional) Path to a base values file where default values can be specified.
    end
  end
end
