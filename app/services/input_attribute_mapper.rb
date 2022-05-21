module InputAttributeMapper
  def map_attribute(argument_name, regex)
    define_method(argument_name.downcase.to_sym) do
      combined_regex = Regexp.new(/#{argument_name}\s*=\s*/.source + regex.source)

      match = raw_attributes.match(combined_regex)&.named_captures || {}
      match.fetch("value", nil)
    end
  end
end
