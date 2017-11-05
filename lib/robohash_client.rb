require 'net/http'
require 'json'

class Robohash
	class << self
		BASE_URL = 'https://robohash.org'
		DEFAULT_DIRECTORY = 'robohash_images'
		BGSET = 'bgset='
		SIZE = 'size='
		SET = 'set='
		OPTIONS = { 
			set: { 
				classic: "#{SET}set1", human: "#{SET}set2", heads: "#{SET}set3", cats: "#{SET}set4", any: "#{SET}any" 
			},
			size: {
				small: "#{SIZE}100x100", medium: "#{SIZE}250x250", large: "#{SIZE}500x500", extra: "#{SIZE}900x900"
			},
			bgset: {
				one: "#{BGSET}bg1", two: "#{BGSET}bg2"
			}
		}

		def get(name, options = {})
			make_request(name, build_query_string(options))
		end

		def get_url(name, options = {})
			puts build_uri(name, build_query_string(options))
		end

		def get_many(names, options = {})
			names.reject! { |name| !name.is_a?(String) || name == '' }
			valid_options = build_query_string(options)
			names.each { |name| make_request(name, valid_options) }
		end

		def get_many_url(names, options = {})
			names.reject! { |name| !name.is_a?(String) || name == '' }
			valid_options = build_query_string(options)
			urls = []
			names.each { |name| urls.push(build_uri(name, valid_options)) }
			urls
		end

		private 

		def build_query_string(options)
			valid_options = extract_valid_options(options)
			return if valid_options.empty?
			
			'?' + valid_options.collect { |option| option }.join('&')
		end

		def extract_valid_options(options)
			valid_options = []

			if options.is_a?(Hash)
				options.each_pair do |key, value|
					inner_hash = OPTIONS.fetch(key, nil)
					option = inner_hash.fetch(value, nil) if inner_hash.is_a?(Hash)
					valid_options.push(option) if option
				end
			end

			valid_options
		end

		def build_uri(name, query_string)
			URI("#{BASE_URL}/#{name}#{query_string}")
		end

		def make_request(name, query_string)
			uri = build_uri(name, query_string)
			response = Net::HTTP.get_response(uri)
			save(response, name)
	  rescue => e
	  	puts "Error obtaining image from #{uri}: #{e.message}"
		end

		def save(image, name)
	    Dir.mkdir(DEFAULT_DIRECTORY) unless Dir.exists? DEFAULT_DIRECTORY

	    open("robohash_images/#{name}.png", 'wb') do |file|
	      file.write(image.body)
	    end

	    puts "Image #{name}.png saved successfully!"
    rescue => e
	  	puts "Error saving image #{name}.png: #{e.message}"
		end
	end
end
