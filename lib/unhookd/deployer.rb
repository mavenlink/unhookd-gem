require 'httparty'

module Unhookd
  class Deployer
    def initialize(branch, chart_values)
      @branch = branch
      @final_values = Unhookd::BaseValues.fetch.merge(chart_values)
      @config = Unhookd.configuration
    end

    def deploy!
      HTTParty.post(
        @config.unhookd_url,
        body: @final_values.to_json,
        query: unhookd_query_params,
        headers: { "Content-Type" => "application/json" },
        verify: false,
      )

      Unhookd::Notifiers::Slack.notify!(@branch) unless @config.slack_webhook_url.nil?
      post_deploy_message
    end

    private

    def unhookd_query_params
      {
        "release" => @branch,
        "chart" => Unhookd.configuration.chart_name,
      }
    end

    def post_deploy_message
      puts "Success! Sent a request to Unhookd with the following values:"
      puts @final_values.inspect
    end
  end
end
