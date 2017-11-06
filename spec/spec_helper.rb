require 'bundler/setup'
Bundler.setup

require 'robohash_client'

RSpec.configure do |config|
  config.default_formatter = 'doc'
  config.order = :random
  Kernel.srand config.seed
end
