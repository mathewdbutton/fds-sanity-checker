# frozen_string_literal: true

class SliceFileStatusComponent < ViewComponent::Base
  attr_reader :validation_run
  def initialize(validation_run:)
    @validation_run = validation_run
  end

  def valid?
    slice_file_count > 0 &&
    z_plane_count > 0 &&
    temperature_slices.size > 0 &&
    visibility_slices.size > 0 &&
    velocity_slices.size > 0 &&
    velocity_slices.where(vector: false).size == 0
  end

  def box_state
    valid? ? "text-white bg-green-500" : "text-black bg-red-500"
  end

  def slice_file_count
    scope.size
  end

  def temperature_slices
    scope.where(quantity: "TEMPERATURE")
  end

  def visibility_slices
    scope.where(quantity: "VISIBILITY")
  end

  def velocity_slices
    scope.where(quantity: "VELOCITY")
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

  private

  def scope
    validation_run.slice_files
  end

end
