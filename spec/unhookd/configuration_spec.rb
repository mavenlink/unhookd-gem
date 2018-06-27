require "spec_helper"

RSpec.describe Unhookd::Configuration do
  context "default values" do
    describe "#unhookd_url" do
      it "has a default value of 'http://localhost:8080'" do
        expect(Unhookd::Configuration.new.unhookd_url).to eq("http://localhost:8080")
      end
    end

    describe "#chart_name" do
      it "has a default value of 'repo/chart'" do
        expect(Unhookd::Configuration.new.chart_name).to eq("repo/chart")
      end
    end

    describe "#repo_name" do
      it "has a default value of 'repo_name'" do
        expect(Unhookd::Configuration.new.repo_name).to eq("repo_name")
      end
    end
  end

  describe "setters" do
    describe "#unhookd_url=" do
      it "can set a value" do
        config = Unhookd::Configuration.new
        config.unhookd_url = "https://some-in-cluster-url.com"
        expect(config.unhookd_url).to eq("https://some-in-cluster-url.com")
      end
    end

    describe "#chart_name=" do
      it "can set a value" do
        config = Unhookd::Configuration.new
        config.chart_name = "somechart/name"
        expect(config.chart_name).to eq("somechart/name")
      end
    end

    describe "#repo_name=" do
      it "can set a value" do
        config = Unhookd::Configuration.new
        config.repo_name = "some_repo"
        expect(config.repo_name).to eq("some_repo")
      end
    end
  end
end
