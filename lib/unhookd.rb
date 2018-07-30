require "unhookd/version"
require "unhookd/configuration"
require "unhookd/deployer"
require "unhookd/notifiers/slack"
require "unhookd/base_values"
require "unhookd/errors/invalid_configuration"

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
    if valid?
      Deployer.new(release_name, chart_values).deploy!
    else
      raise InvalidConfiguration, "some required args were missing"
    end
  end

  def self.valid?
    !configuration.unhookd_url.nil? && !configuration.chart_name.nil?
  end

  private_class_method :valid?
end
