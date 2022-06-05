module Mapper
  module InputAttribute

    def self.extended(klass)
    end

    mattr_reader :field_map_logging


    @@field_map_logging = Hash.new {|hsh, key| hsh[key] = [] }
    def add_mapped_field(value)
      @@field_map_logging[self.to_s] << value
    end

    def map_attribute(argument_name, regex)
      add_mapped_field(argument_name)
      define_method(argument_name.downcase.to_sym) do
        combined_regex = Regexp.new(/#{argument_name}\s*=\s*/.source + regex.source)

        match = raw_attributes.match(combined_regex)&.named_captures || {}
        match.fetch("value", nil)
      end
    end
  end
end
