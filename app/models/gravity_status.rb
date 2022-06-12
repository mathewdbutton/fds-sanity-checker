require 'fds_math'

class GravityStatus
  include ActiveModel::Validations

  GRAVITY = 9.81

  validate :y_must_be_zero
  validate :coponents_must_equal_gravity

  def initialize(validation_run)
    @validation_run = validation_run
  end

  def scope
    @scope ||= @validation_run.misc || Misc.default
  end

  def using_default?
    @validation_run.misc.blank? || @validation_run.misc.gvec_x.blank?
  end

  def defined_gravity
    @defined_gravity ||= FDSMath.pythagoras_theorem(scope.gvec_x.to_f, scope.gvec_z.to_f)
  end

  private

  def y_must_be_zero
    if scope.gvec_y != 0
      errors.add(:gvec_y, "must be equal to zero. Altering gravity on the y plane has no effect the model.")
    end
  end

  def coponents_must_equal_gravity
    if defined_gravity != GRAVITY
      errors.add(:base, "GVEC vector should be 9.81")
    end
  end

end
