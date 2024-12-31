require 'yaml'

module Constants
  CONFIG = YAML.load_file(Rails.root.join('config/constants.yml')).deep_symbolize_keys

  BUSINESS_NAMES = CONFIG[:business_names]
  AREAS = CONFIG[:areas]
end
