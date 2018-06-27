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

      notify_slack unless @config.slack_webhook_url.nil?
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

    def notify_slack
      HTTParty.post(
        @config.slack_webhook_url,
        body: slack_webhook_body,
        headers: { "Content-Type" => "application/json" },
        verify: false,
      )
    end

    def slack_webhook_body
      {
        "attachments" => [
          {
            "fallback" => "Your branch was deployed!",
            "color" => "#36a64f",
            "pretext" => "The '#{@branch}' branch was deployed!",
            "author_name" => "Unhookd",
            "text" => @config.slack_webhook_message,
            "ts" => Time.now.to_i
          }
        ]
      }.to_json
    end

    def post_deploy_message
      puts "Success! Sent a request to Unhookd with the following values:"
      puts @final_values.inspect
    end
  end
end
