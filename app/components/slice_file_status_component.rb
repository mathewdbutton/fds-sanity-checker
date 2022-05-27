# frozen_string_literal: true

class SliceFileStatusComponent < ViewComponent::Base
  attr_reader :validation_run, :validator

  delegate *%i[temperature_slices visibility_slices velocity_slices scope valid?], to: :validator

  def initialize(validation_run:)
    @validation_run = validation_run
    @validator = SliceFileStatus.new(validation_run)
  end

  def errors
    validator.valid?
    validator.errors.full_messages
  end

  def box_state
    valid? ? "text-white bg-green-500" : "text-black bg-red-500"
  end

end
