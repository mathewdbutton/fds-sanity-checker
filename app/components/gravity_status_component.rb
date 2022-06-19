# frozen_string_literal: true

class GravityStatusComponent < ViewComponent::Base
  delegate :defined_gravity, :using_default?, to: :status_model

  attr_reader :status_model, :validation_run, :text_offset, :arrow_size, :axis_length, :multiplier

  def initialize(validation_run:)
    @validation_run = validation_run
    @status_model = GravityStatus.new(validation_run)
    @axis_length = 125
    @text_offset = 10
    @arrow_size = 10
  end

  def slope_direction
    if gvec_x.positive?
      "sloping upwards"
    elsif gvec_x.negative?
      "sloping downwards"
    else
      "flat"
    end
  end

  def gvec_x
    status_model.scope.gvec_x
  end

  def gvec_z
    status_model.scope.gvec_z
  end

  def slope_angle
    (90 + FDSMath.to_polar(gvec_x, gvec_z)[1]).round(2)
  end

  def slope_percentage
    (100 * Math.tan(FDSMath.to_radians(slope_angle))).round(2)
  end

  def slope_details_position
    radius, degree = FDSMath.to_polar(gvec_x, gvec_z)
    FDSMath.to_cartesian(1, -90-degree)
  end

  def new_slope(change)
    radius, degree = FDSMath.to_polar(gvec_x, gvec_z)
    FDSMath.to_cartesian(2, degree + change)
  end

  def gvec_x_normalised
    radius, degree = FDSMath.to_polar(gvec_x, gvec_z)
    FDSMath.to_cartesian(2, degree)[0]
  end

  def gvec_z_normalised
    radius, degree = FDSMath.to_polar(gvec_x, gvec_z)
    FDSMath.to_cartesian(2, degree)[1]
  end

  def units
    "m/s<sup>2</sup>".html_safe
  end

  def tooltip
    return "Using default" if using_default?

    "&radic;(x^2 + z^2) = #{defined_gravity}".html_safe
  end
end
