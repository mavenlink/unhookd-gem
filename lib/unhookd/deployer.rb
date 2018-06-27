module Unhookd
  class Deployer
    def initialize(sha, branch, chart_values)
      @branch = branch
      @sha = sha
      @final_values = { "values" => chart_values }
      @config = Unhookd.configuration
    end

    def deploy!
      HTTParty.post(
        @config.unhookd_url,
        body: get_values.to_json,
        headers: { "Content-Type" => "application/json" },
        verify: false,
      )
    end

    private

    def get_values
      @final_values.merge!(
        {
          "branch" => @branch,
          "release" => @branch,
          "repo" => @config.repo_name,
          "chart" => @config.chart_name,
        }
      )
    end
  end
end
