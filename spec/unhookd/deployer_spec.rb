require 'spec_helper'

RSpec.describe Unhookd::Deployer do
  describe "#deploy" do
    let(:release_name) { "my-release_name" }
    let(:values_file_path) { "spec/fixtures/sample-values.yaml" }
    let(:file_values) { YAML.load_file(values_file_path) }
    let(:chart_values) { { "foo" => 'bar' } }

    let(:expected_unhookd_query) { {
      "release" => release_name,
      "chart" => Unhookd.configuration.chart_name,
    }}

    let(:expected_unhookd_url) { Unhookd.configuration.unhookd_url}
    let(:expected_unhookd_body) { file_values.merge(chart_values).to_json }
    let(:expected_unhookd_headers) { { "Content-Type" => "application/json" } }

    subject { described_class.new(release_name, chart_values) }

    before do
      Unhookd.configure do |config|
        config.values_file_path = values_file_path
      end
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

        it "tells the Slack Notifier to send a notification" do
          allow(Unhookd::Notifiers::Slack).to receive(:notify!)

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

    describe "async" do
      context "when async is set" do
        let(:expected_unhookd_query) { {
          "release" => release_name,
          "chart" => Unhookd.configuration.chart_name,
          "async" => Unhookd.configuration.async
        }}

        before do
          Unhookd.configure do |config|
            config.async = true
          end
        end

        it "sends the async query parameter" do
          expect(HTTParty)
            .to receive(:post)
              .with(expected_unhookd_url, body: expected_unhookd_body, query: expected_unhookd_query, headers: expected_unhookd_headers, verify: false)

          subject.deploy!
        end
      end

      context "when async is not set" do
        before do
          expect(Unhookd.configuration.async).to be_falsey
          expect(expected_unhookd_query.keys).not_to include(:async)
        end

        it "does not send the async query parameter" do
          expect(HTTParty)
            .to receive(:post)
              .with(expected_unhookd_url, body: expected_unhookd_body, query: expected_unhookd_query, headers: expected_unhookd_headers, verify: false)

          subject.deploy!
        end
      end
    end
  end
end
