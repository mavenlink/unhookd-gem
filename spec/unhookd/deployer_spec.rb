require 'spec_helper'

RSpec.describe Unhookd::Deployer do
  describe "#deploy" do
    let(:sha) { "123" }
    let(:branch) { "my-branch" }
    let(:chart_values) { { "foo" => 'bar' } }
    let(:default_values) do
      {
        "branch" => branch,
        "release" => branch,
        "repo" => Unhookd.configuration.repo_name,
        "chart" => Unhookd.configuration.chart_name,
      }
    end
    let(:expected_unhookd_url) { Unhookd.configuration.unhookd_url}
    let(:expected_unhookd_body) { { "values" => chart_values }.merge(default_values).to_json }
    let(:expected_unhookd_headers) { { "Content-Type" => "application/json" } }

    subject { described_class.new(sha, branch, chart_values) }
    
    it "sends a request to the configured endpoint with the correct values" do
      expect(HTTParty)
        .to receive(:post)
        .with(expected_unhookd_url, body: expected_unhookd_body, headers: expected_unhookd_headers, verify: false)

      subject.deploy!
    end

    context "when a slack_webhook_url has been configured" do
      let(:slack_webhook_url) { "http://my-slack-webhook-url.com" }
      let(:expected_slack_url) { Unhookd.configuration.slack_webhook_url }
      let(:expected_slack_body) do
        {
          "attachments" => [
            {
              "fallback" => "Your branch was deployed!",
              "color" => "#36a64f",
              "pretext" => "The '#{branch}' branch was deployed!",
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

      after do
        Unhookd.reset
      end

      it "also sends a request to notify slack of a successful deployment" do
        expect(HTTParty)
          .to receive(:post)
          .with(expected_unhookd_url, body: expected_unhookd_body, headers: expected_unhookd_headers, verify: false)

        expect(HTTParty)
          .to receive(:post)
          .with(expected_slack_url, body: expected_slack_body, headers: expected_slack_headers, verify: false)

        subject.deploy!
      end
    end

    context "when a slack_webhook_url has not been configured" do
      let(:expected_slack_url) { Unhookd.configuration.slack_webhook_url }

      it "does not send a notification to slack" do
        expect(HTTParty)
          .to receive(:post)
          .with(expected_unhookd_url, body: expected_unhookd_body, headers: expected_unhookd_headers, verify: false)

        expect(HTTParty)
          .to_not receive(:post)
          .with(expected_slack_url, any_args)

        subject.deploy!
      end
    end
  end
end