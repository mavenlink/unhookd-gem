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
              "pretext" => @config.slack_webhook_message[:header],
              "author_name" => "Unhookd",
              "title" => @config.slack_webhook_message[:title],
              "title_link" => @config.slack_webhook_message[:title_link],
              "text" => @config.slack_webhook_message[:text],
              "ts" => Time.now.to_i
            }
          ]
        }.to_json

        HttpFactory.post(
          @config.slack_webhook_url,
          body: slack_webhook_body,
          headers: { "Content-Type" => "application/json" },
          verify: false,
        )
      end
    end
  end
end
