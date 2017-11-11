require 'net/http'
require 'pry'
require_relative './robohash_client/robohash_validator'
require_relative './robohash_client/robohash_resquester'

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
	    Dir.mkdir(@default_dir) unless Dir.exists? @default_dir

	    open("robohash_images/#{name}.png", 'wb') do |file|
	      file.write(image.body)
	    end

	    puts "Image #{name}.png saved successfully!"
    rescue => e
	  	puts "Error saving image #{name}.png: #{e.message}"
		end
	end
end
