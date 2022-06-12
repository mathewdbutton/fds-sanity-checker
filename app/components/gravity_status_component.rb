# frozen_string_literal: true

class GravityStatusComponent < ViewComponent::Base
  delegate :defined_gravity, :using_default?, to: :status_model

  attr_reader :status_model, :validation_run

  def initialize(validation_run:)
    @validation_run = validation_run
    @status_model = GravityStatus.new(validation_run)
  end

  def slope_direction
    if status_model.scope.gvec_x.positive?
      "sloping downwards"
    elsif status_model.scope.gvec_x.negative?
      "sloping upwards"
    else
      "flat"
    end
  end

  def units
    "m/s<sup>2</sup>".html_safe
  end

  def tooltip
    return "Using default" if using_default?

    "&radic;(x^2 + z^2) = #{defined_gravity}".html_safe
  end
end
