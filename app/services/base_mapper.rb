class BaseMapper
  extend InputAttributeMapper

  def self.call(...)
    new(...).call
  end

  def initialize(tuple, validation_run)
    @raw_attributes = tuple.arguments
    @validation_run = validation_run
  end

  private

  attr_reader :raw_attributes, :validation_run
end
