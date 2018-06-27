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
end
