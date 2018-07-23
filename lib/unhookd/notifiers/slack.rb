module Unhookd
  module Notifiers
    class Slack
      def self.notify!
        @config = Unhookd.configuration

        slack_webhook_body = {
          "attachments" => [
            {
              "fallback" => "Your branch was deployed!",
              "color" => "#36a64f",
              "pretext" => "Something was deployed!",
              "author_name" => "Unhookd",
              "text" => @config.slack_webhook_message,
              "ts" => Time.now.to_i
            }
          ]
        }.to_json

        HTTParty.post(
          @config.slack_webhook_url,
          body: slack_webhook_body,
          headers: { "Content-Type" => "application/json" },
          verify: false,
        )
      end
    end
  end
end
