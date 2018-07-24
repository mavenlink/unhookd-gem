require 'spec_helper'

RSpec.describe Unhookd::Notifiers::Slack do
  describe '.notify!' do
    let(:branch) { "my-branch" }
    let(:slack_webhook_url) { "http://my-slack-webhook-url.com" }
    let(:expected_slack_url) { Unhookd.configuration.slack_webhook_url }
    let(:expected_slack_body) do
      {
        "attachments" => [
          {
            "fallback" => "Your branch was deployed!",
            "color" => "#36a64f",
            "pretext" => "Something was deployed!",
            "author_name" => "Unhookd",
            "text" => Unhookd.configuration.slack_webhook_message,
            "ts" => Time.now.to_i
          }
        ]
      }.to_json
    end

    let(:expected_slack_headers) { { "Content-Type" => "application/json" } }

    before do
      Unhookd.configure do |config|
        config.slack_webhook_url = slack_webhook_url
      end
    end

    it "sends a request to slack with the correct params" do
      expect(HTTParty)
        .to receive(:post)
        .with(expected_slack_url, body: expected_slack_body, headers: expected_slack_headers, verify: false)

      described_class.notify!
    end
  end
end
