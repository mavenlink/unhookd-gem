#

module Unhookd
  class Deployer
    def initialize(release_name, chart_values)
      @release_name = release_name
      @final_values = Unhookd::BaseValues.fetch.merge(chart_values)
      @config = Unhookd.configuration
    end

    def deploy!
      HttpFactory.post(
        @config.unhookd_url,
        body: @final_values.to_json,
        query: unhookd_query_params,
        headers: { "Content-Type" => "application/json" },
        verify: false,
      )

      Unhookd::Notifiers::Slack.notify! unless @config.slack_webhook_url.nil?
      post_deploy_message
    end

    private

    def unhookd_query_params
      {
        "release" => @release_name,
        "chart" => Unhookd.configuration.chart_name,
        "async" => Unhookd.configuration.async,
        "namespace" => Unhookd.configuration.namespace,
      }.delete_if { |_key, value| value.nil? }
    end

    def post_deploy_message
      puts "Success! Sent a request to Unhookd with the following values:"
      puts @final_values.inspect
    end
  end
end
