# frozen_string_literal: true

require 'net/http'
require_relative './robohash_client/robohash_validator'
require_relative './robohash_client/robohash_resquester'

# Client for robohash.org
class RobohashClient
  BASE_URL = 'https://robohash.org'
  DEFAULT_DIRECTORY = 'robohash_images'

  class << self
    attr_accessor :default_dir
    @default_dir = DEFAULT_DIRECTORY
    @requester = RobohashRequester.new
    @validator = RobohashValidator.new

    def get(name, options = {})
      return 'Name should be an non-empty String!' if @validator.invalid_name(name)

      @requester.make_request(name, @requester.build_query_string(options))
    end

    def get_url(name, options = {})
      return 'Name should be an non-empty String!' if @validator.invalid_name(name)

      @requester.build_uri(name, @requester.build_query_string(options)).to_s
    end

    def get_many(names, options = {})
      valid_names = @validator.extract_valid_names(names)
      valid_options = @requester.build_query_string(options) unless valid_names.empty?
      valid_names.each { |name| @requester.make_request(name, valid_options) }
    end

    def get_many_url(names, options = {})
      urls = []
      valid_names = @validator.extract_valid_names(names)
      valid_options = @requester.build_query_string(options) unless valid_names.empty?
      valid_names.each { |name| urls.push(@requester.build_uri(name, valid_options).to_s) }
      urls
    end

    def reset_default_dir
      @default_dir = DEFAULT_DIRECTORY
    end

    private

    def save(image, name)
      dir = @default_dir || DEFAULT_DIRECTORY
      Dir.mkdir(dir) unless Dir.exist? dir

      File.open(File.join(dir.to_s, "#{name}.png"), 'wb') do |file|
        file.write(image.body)
      end

      puts "Image #{name}.png saved successfully on #{dir}!"
    rescue StandardError => e
      puts "Error saving image #{name}.png: #{e.message}"
    end
  end
end
