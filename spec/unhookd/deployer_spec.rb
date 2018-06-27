require 'spec_helper'

RSpec.describe Unhookd::Deployer do
  describe "#deploy" do
    let(:sha) { "123" }
    let(:branch) { "my-branch" }
    let(:expected_url) { Unhookd.configuration.unhookd_url}
    let(:expected_body) do
      {
        "branch" => branch,
        "release" => branch,
        "repo" => Unhookd.configuration.repo_name,
        "chart" => Unhookd.configuration.chart_name,
      }.to_json
    end
    let(:expected_headers) { { "Content-Type" => "application/json" } }

    subject { described_class.new(sha, branch) }

    it "sends a request to the configured endpoint with the correct values" do
      expect(HTTParty)
        .to receive(:post)
        .with(expected_url, body: expected_body, headers: expected_headers, verify: false)

      subject.deploy!
    end
  end
end