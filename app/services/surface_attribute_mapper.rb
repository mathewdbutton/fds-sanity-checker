class SurfaceAttributeMapper
  def self.call(...)
    new(...).call
  end

  attr_reader :raw_attributes, :validation_run

  def initialize(tuple, validation_run)
    @raw_attributes = tuple.arguments
    @validation_run = validation_run
  end

  def call
    Surface.create(volume_flow: volume_flow, char_id: id, validation_run: validation_run)
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
