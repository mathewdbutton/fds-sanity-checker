# frozen_string_literal: true

class SliceFileStatusComponent < ViewComponent::Base
  attr_reader :validation_run, :status_model

  delegate *%i[temperature_slices visibility_slices velocity_slices scope valid?], to: :status_model

  def initialize(validation_run:)
    @validation_run = validation_run
    @status_model = SliceFileStatus.new(validation_run)
  end

  def z_plane_count
    scope.where.not(pbz: nil).size
  end

  def x_plane_count
    scope.where.not(pbx: nil).size
  end

  def y_plane_count
    scope.where.not(pby: nil).size
  end

  def errors
    status_model.valid?
    status_model.errors.full_messages
  end

  def box_state
    valid? ? "text-white bg-green-500" : "text-black bg-red-500"
  end

end
