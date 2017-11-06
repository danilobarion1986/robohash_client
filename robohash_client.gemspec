$LOAD_PATH << File.expand_path('../lib', __FILE__)
# Adds the subfolder /lib (relative to this file), to the Ruby's load path array.
# So other files from this gem can be required

require 'robohash_client/version'
gem_name = 'robohash_client'

Gem::Specification.new do |s|
  s.name        = gem_name
  s.version     = Robohash::VERSION
  s.date        = '2017-11-05'
  s.summary     = "Client for Robohash.org"
  s.description = "A simple client to get robohash avatar's from Robohash.org."
  s.authors     = ["Danilo Barion Nogueira"]
  s.email       = 'danilo.barion1986@live.com'
  s.files       = ["lib/robohash_client.rb"]
  s.homepage    = "http://rubygems.org/gems/#{gem_name}"
  s.license       = 'MIT'
  s.add_development_dependency 'rspec', '~> 3'
  s.required_ruby_version = '>= 1.9'
  s.post_install_message = "=========================\n\n WE ARE THE ROBOTS! \n\n ========================="
end
