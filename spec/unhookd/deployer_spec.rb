require 'spec_helper'

RSpec.describe Unhookd::Deployer do
  describe "#deploy" do
    let(:sha) { "123" }
    let(:branch) { "my-branch" }

    it "exists" do
      expect { described_class.new(sha, branch).deploy! }.to_not raise_error
    end
  end
end