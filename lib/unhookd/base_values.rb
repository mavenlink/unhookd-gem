require 'yaml'

module Unhookd
  class BaseValues
    def self.fetch
      Unhookd.configuration.values_file_path.nil? ?  {} : YAML.load_file(Unhookd.configuration.values_file_path)
    end
  end
end
