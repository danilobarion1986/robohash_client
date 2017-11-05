$:.push File.expand_path('../lib', __FILE__)
require 'robohash_client/version'

Gem::Specification.new do |s|
  s.name        = 'robohash_client'
  s.version     = Robohash::VERSION
  s.date        = '2017-11-05'
  s.summary     = "Client for Robohash.org"
  s.description = "A simple client to get robohash avatar's from Robohash.org."
  s.authors     = ["Danilo Barion Nogueira"]
  s.email       = 'danilo.barion1986@live.com'
  s.files       = ["lib/robohash_client.rb"]
  s.homepage    =
    'http://rubygems.org/gems/robohash_client'
  s.license       = 'MIT'
end