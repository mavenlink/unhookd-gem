require 'spec_helper'

RSpec.describe Unhookd::Deployer do
  describe "#deploy" do
    let(:sha) { "123" }
    let(:branch) { "my-branch" }
    let(:values_file_path) { "spec/fixtures/sample-values.yaml" }
    let(:file_values) { YAML.load_file(values_file_path) }
    let(:chart_values) { { "foo" => 'bar' } }

    let(:expected_unhookd_query) { {
      "release" => branch,
      "chart" => Unhookd.configuration.chart_name,
    }}

    let(:expected_unhookd_url) { Unhookd.configuration.unhookd_url}
    let(:expected_unhookd_body) { file_values.merge(chart_values).to_json }
    let(:expected_unhookd_headers) { { "Content-Type" => "application/json" } }

    subject { described_class.new(sha, branch, chart_values) }

    before do
      Unhookd.configure do |config|
        config.values_file_path = values_file_path
      end
    end

    after do
      Unhookd.reset
    end

    it "sends a request to the configured endpoint with the correct values" do
      expect(HTTParty)
        .to receive(:post)
        .with(expected_unhookd_url, body: expected_unhookd_body, query: expected_unhookd_query, headers: expected_unhookd_headers, verify: false)

      subject.deploy!
    end

    describe "notifying slack" do
      before do
        allow(HTTParty).to receive(:post)
      end

      context "when a slack_webhook_url has been configured" do
        let(:slack_webhook_url) { "http://my-slack-webhook-url.com" }

        before do
          Unhookd.configure do |config|
            config.slack_webhook_url = slack_webhook_url
          end
        end

        after do
          Unhookd.reset
        end

        it "tells the Slack Notifier to send a notification" do
          allow(Unhookd::Notifiers::Slack).to receive(:notify!).with(branch)

          subject.deploy!
        end
      end

      context "when a slack_webhook_url has not been configured" do
        it "does not tell the Slack Notifier to send a notification" do
          expect(Unhookd::Notifiers::Slack).to_not receive(:notify!)

          subject.deploy!
        end
      end
    end
  end
end
