require "unhookd/version"
require "unhookd/configuration"
require "unhookd/deployer"
require "unhookd/notifiers/slack"
require "unhookd/base_values"

module Unhookd
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.deploy!(release_name, chart_values)
    Unhookd::Deployer.new(release_name, chart_values).deploy!
  end
end
