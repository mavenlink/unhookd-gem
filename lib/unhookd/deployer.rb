require 'httparty'

module Unhookd
  class Deployer
    def initialize(sha, branch, chart_values)
      @branch = branch
      @sha = sha
      @final_values = { "values" => chart_values }
      @config = Unhookd.configuration
    end

    def deploy!
      HTTParty.post(
        @config.unhookd_url,
        body: get_values.to_json,
        headers: { "Content-Type" => "application/json" },
        verify: false,
      )

      Unhookd::Notifiers::Slack.notify!(@branch) unless @config.slack_webhook_url.nil?
      post_deploy_message
    end

    private

    def get_values
      @final_values.merge!(
        {
          "branch" => @branch,
          "release" => @branch,
          "repo" => @config.repo_name,
          "chart" => @config.chart_name,
        }
      )
    end

    def post_deploy_message
      puts "Success! Sent a request to Unhookd with the following values:"
      puts @final_values.inspect
    end
  end
end
