class SurfaceAttributeMapper
  def self.call(raw_attributes)
    new(raw_attributes).call
  end

  attr_reader :raw_attributes

  def initialize(raw_attributes)
    @raw_attributes = raw_attributes
  end

  def call
    Surface.create(volume_flow: volume_flow, char_id: id)
  end

  private

  ARGUMENTS = {
    VOLUME_FLOW: RegexLibrary::REAL_NUMBER,
    ID: RegexLibrary::WORD
  }

  ARGUMENTS.each do |argument_name, regex|
    define_method(argument_name.downcase.to_sym) do
      raw_attributes.match(Regexp.new(/#{argument_name}=/.source + regex.source))[:value]
    end
  end
end
