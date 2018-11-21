require "spec_helper"

RSpec.describe Unhookd::Configuration do
  context "default values" do
    describe "#unhookd_url" do
      it "has a default value of nil" do
        expect(Unhookd::Configuration.new.unhookd_url).to eq(nil)
      end
    end

    describe "#chart_name" do
      it "has a default value of nil" do
        expect(Unhookd::Configuration.new.chart_name).to eq(nil)
      end
    end

    describe "#slack_webhook_url" do
      it "has a default value of nil" do
        expect(Unhookd::Configuration.new.slack_webhook_url).to eq(nil)
      end
    end

    describe "#slack_webhook_message" do
      it "has a default value of nil" do
        expect(Unhookd::Configuration.new.slack_webhook_message).to eq({
          header: "Something was deployed!",
          title: nil,
          title_link: nil,
          message: nil,
        })
      end
    end

    describe "#values_file_path" do
      it "has a default value of nil" do
        expect(Unhookd::Configuration.new.values_file_path).to eq(nil)
      end
    end

    describe "#async" do
      it "has a default value of nil" do
        expect(Unhookd::Configuration.new.async).to eq(nil)
      end
    end

    describe "#namespace" do
      it "has a default value of nil" do
        expect(Unhookd::Configuration.new.namespace).to eq(nil)
      end
    end

    describe "#logger" do
      it "has a default value of nil" do
        expect(Unhookd::Configuration.new.logger).to eq(nil)
      end
    end

    describe "#read_timeout" do
      it "has a default value of 120" do
        expect(Unhookd::Configuration.new.read_timeout).to eq(120)
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

    describe "#slack_webhook_url=" do
      it "can set a value" do
        config = Unhookd::Configuration.new
        config.slack_webhook_url = "http://some-slack-webhook-url.com"
        expect(config.slack_webhook_url).to eq("http://some-slack-webhook-url.com")
      end
    end

    describe "#slack_webhook_message=" do
      it "can set a value" do
        config = Unhookd::Configuration.new
        config.slack_webhook_message = { header: "hey", title: nil, title_link: "foo", text: "bar"}
        expect(config.slack_webhook_message).to eq({ header: "hey", title: nil, title_link: "foo", text: "bar"})
      end
    end

    describe "#values_file_path=" do
      it "can set a value" do
        config = Unhookd::Configuration.new
        config.values_file_path = "foo/bar/path.yaml"
        expect(config.values_file_path).to eq("foo/bar/path.yaml")
      end
    end

    describe "#async=" do
      it "can set a value" do
        config = Unhookd::Configuration.new
        config.async = true
        expect(config.async).to eq(true)
      end
    end

    describe "#namespace=" do
      it "can set a value" do
        config = Unhookd::Configuration.new
        config.namespace = 'foo'
        expect(config.namespace).to eq('foo')
      end
    end

    describe "#logger=" do
      it "can set a value" do
        config = Unhookd::Configuration.new
        config.logger = 'foo'
        expect(config.logger).to eq('foo')
      end
    end

    describe "#read_timeout=" do
      it "can set a value" do
        config = Unhookd::Configuration.new
        config.read_timeout = 'foo'
        expect(config.read_timeout).to eq('foo')
      end
    end
  end
end
