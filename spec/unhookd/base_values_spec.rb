require "spec_helper"

RSpec.describe Unhookd::BaseValues do
  describe ".fetch" do
    context "when the user has configured a values file path" do
      let(:values_file_path) { "spec/fixtures/sample-values.yaml" }
      let(:expected_values_file_hash) { YAML.load_file(values_file_path) }

      before do
        Unhookd.configure do |config|
          config.values_file_path = values_file_path
        end
      end

      it "returns that file loaded as a hash" do
        expect(described_class.fetch).to eq(expected_values_file_hash)
      end
    end

    context "when the user has not configured a values file path" do
      it "returns an empty hash" do
        expect(described_class.fetch).to eq({})
      end
    end
  end
end
