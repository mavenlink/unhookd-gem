#

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
      raise Errors::InvalidConfiguration, "some required args were missing"
    end
  end

  def self.valid?
    !configuration.unhookd_url.nil? && !configuration.chart_name.nil?
  end

  private_class_method :valid?

  autoload :Version, "unhookd/version"
  autoload :Configuration, "unhookd/configuration"
  autoload :HttpFactory, "unhookd/http_factory"
  autoload :Deployer, "unhookd/deployer"
  autoload :BaseValues, "unhookd/base_values"
  autoload :Notifiers, "unhookd/notifiers"
  autoload :Errors, "unhookd/errors"
end
