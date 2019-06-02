# frozen_string_literal: true

# Class responsible for validate the options passed to the client
class RobohashValidator
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
  }.freeze

  def extract_valid_names(names)
    return [] unless names.is_a?(Array)

    names.reject { |name| invalid_name(name) }
  end

  def invalid_name(name)
    !name.is_a?(String) || name == ''
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
end
