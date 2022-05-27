class SliceFileStatus
  include ActiveModel::Validations

  validate :required_quantities_in_z_plane
  validate :all_velocity_slices_have_a_vector

  def initialize(validation_run)
    @validation_run = validation_run
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

  def temperature_slices
    scope.where(quantity: "TEMPERATURE")
  end

  def visibility_slices
    scope.where(quantity: "VISIBILITY")
  end

  def velocity_slices
    scope.where(quantity: "VELOCITY")
  end

  def scope
    validation_run.slice_files
  end

  private

  attr_reader :validation_run

  def required_quantities_in_z_plane
    unless visibility_slices.where.not(pbz: nil).size > 0
      errors.add(:base, "Must have at least one 'Visibility' slice file on the z plane")
    end

    unless temperature_slices.where.not(pbz: nil).size > 0
      errors.add(:base, "Must have at least one 'Temperature' slice file on the z plane")
    end

    unless velocity_slices.where.not(pbz: nil).size > 0
      errors.add(:base, "Must have at least one 'Velocity' slice file on the z plane")
    end
  end

  def all_velocity_slices_have_a_vector
    unless velocity_slices.where(vector: false).size == 0
      errors.add(:base, "All 'Velocity' slice files must have 'VECTOR' set to true")
    end
  end
end
