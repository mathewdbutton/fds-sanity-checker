class VentAttributeMapper
  def self.call(raw_attributes)
    new(raw_attributes).call
  end

  attr_reader :raw_attributes, :validation_run

  def initialize(tuple, validation_run)
    @raw_attributes = tuple.arguments
    @validation_run = validation_run
  end

  def call
    Vent.create(surf_id: surf_id, validation_run: validation_run)
  end

  private

  ARGUMENTS = {
    SURF_ID: RegexLibrary::WORD
  }

  ARGUMENTS.each do |argument_name, regex|
    define_method(argument_name.downcase.to_sym) do
      raw_attributes.match(Regexp.new(/#{argument_name}=/.source + regex.source))[:value]
    end
  end
end
