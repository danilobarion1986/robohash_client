# frozen_string_literal: true

$LOAD_PATH << File.expand_path('../lib', __FILE__)
# Adds the subfolder /lib (relative to this file), to the Ruby's load path array.
# So other files from this gem can be required

require_relative 'lib/robohash_client/version'
GEM_NAME = 'robohash_client'

Gem::Specification.new do |s|
  s.name        = GEM_NAME
  s.version     = Robohash::VERSION
  s.date        = '2017-11-05'
  s.summary     = 'Client for robohash.org'
  s.description = 'A simple client to get robohash avatar\'s from robohash.org.'
  s.author      = 'Danilo Barion Nogueira'
  s.email       = 'danilo.barion1986@live.com'
  s.files       = ['lib/robohash_client.rb']

  # all application-style files are expected to be found in bindir.
  # These files must be executable Ruby files. Files that use bash or other interpreters will not work.
  s.bindir      = 'bin'
  s.executables << 'robohash-client'
  s.homepage = "http://rubygems.org/gems/#{GEM_NAME}"
  s.license = 'MIT'

  s.add_development_dependency 'pry'
  s.add_development_dependency 'rspec', '~> 3'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-performance'

  s.required_ruby_version = '>= 1.9'
  s.post_install_message = "=========================\n\n   WE ARE THE ROBOTS! \n\n========================="
  s.metadata = {
    'homepage_uri' => 'https://github.com/danilobarion1986/robohash_client',
    'documentation_uri' => 'https://github.com/danilobarion1986/robohash_client/blob/master/README.md',
    'source_code_uri' => 'https://github.com/danilobarion1986/robohash_client',
    'bug_tracker_uri' => 'https://github.com/danilobarion1986/robohash_client/issues'
  }
end
