require "unhookd/version"
require "unhookd/configuration"
require "unhookd/deployer"

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

  def self.deploy!
    Unhookd::Deployer.new.deploy!
  end
end
