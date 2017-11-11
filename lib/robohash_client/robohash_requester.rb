class RobohashRequester
  def build_query_string(options)
    valid_options = RobohashValidator.extract_valid_options(options)
    return if valid_options.empty?

    '?' + valid_options.collect { |option| option }.join('&')
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
end