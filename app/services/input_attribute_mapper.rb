module InputAttributeMapper
  def map_attribute(argument_name, regex)
    self.define_method(argument_name.downcase.to_sym) do
      match = raw_attributes.match(Regexp.new(/#{argument_name}\s*=\s*/.source + regex.source))
      if match.present?
        match[:value]
      else
        match
      end
    end
  end
end
