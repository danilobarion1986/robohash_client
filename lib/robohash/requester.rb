# frozen_string_literal: true

module Robohash
  # Class responsible for HTTP requests for robohash.org
  class Requester
    def build_uri(name, query_string)
      URI("#{BASE_URL}/#{name}#{query_string}")
    end

    def make_request(name, options)
      uri = build_uri(name, build_query_string(options))
      response = Net::HTTP.get_response(uri)
      save(response, name)
    rescue StandardError => e
      puts "Error obtaining image from #{uri}: #{e.message}"
    end

    private

    def build_query_string(options)
      return if (options || {}).empty?

      '?' + options.select! { |option| option }.join('&')
    end
  end
end
