require "spec_helper"

RSpec.describe Unhookd do
  it "has a version number" do
    expect(Unhookd::VERSION).not_to be nil
  end

  describe "#configure" do
    before do
      Unhookd.configure do |config|
        config.unhookd_url = 'www.some-url-in-a-cluster.com'
      end
    end

    it "allows you to set keys on the configuration object" do
      config = Unhookd.configuration

      expect(config.unhookd_url).to eq('www.some-url-in-a-cluster.com')
    end

    after :each do
      Unhookd.reset
    end
  end

  describe ".reset" do
    before :each do
      Unhookd.configure do |config|
        config.unhookd_url = 'www.some-url-in-a-cluster.com'
      end
    end

    it "resets the configuration" do
      Unhookd.reset

      config = Unhookd.configuration

      expect(config.unhookd_url).to eq(Unhookd::Configuration.new.unhookd_url)
    end
  end

  describe ".deploy!" do
    let(:sha) { '123' }
    let(:branch) { 'my-branch' }
    let(:deployer_stub) { Unhookd::Deployer.new(sha, branch) }

    it "initialize an Unhookd::Deployer with passed args and calls deploy on it" do
      expect(Unhookd::Deployer).to receive(:new).with(sha, branch).and_return(deployer_stub)
      expect(deployer_stub).to receive(:deploy!)

      Unhookd.deploy!(sha, branch)
    end
  end
end
