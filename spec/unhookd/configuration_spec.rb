require "spec_helper"

RSpec.describe Unhookd::Configuration do
  context "default values" do
    describe "#unhookd_url" do
      it "default value is 'http://localhost:8080'" do
        expect(Unhookd::Configuration.new.unhookd_url).to eq("http://localhost:8080")
      end
    end
  end

  describe "#unhookd_url=" do
    it "can set value" do
      config = Unhookd::Configuration.new
      config.unhookd_url = "https://some-in-cluster-url.com"
      expect(config.unhookd_url).to eq("https://some-in-cluster-url.com")
    end
  end
end
