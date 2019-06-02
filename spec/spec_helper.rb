# frozen_string_literal: true

require 'bundler/setup'
require 'pry'

Bundler.setup

%w[requester validator client].each { |filename| require_relative "../lib/robohash/#{filename}" }

RSpec.configure do |config|
  config.default_formatter = 'doc'
  config.order = :random
  Kernel.srand config.seed
end
