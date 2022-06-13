# frozen_string_literal: true

class GravityStatusComponent < ViewComponent::Base
  delegate :defined_gravity, :using_default?, to: :status_model

  attr_reader :status_model, :validation_run, :text_offset, :arrow_size, :axis_length

  def initialize(validation_run:)
    @validation_run = validation_run
    @status_model = GravityStatus.new(validation_run)
    @axis_length = 125
    @text_offset = 10
    @arrow_size = 10
  end

  def slope_direction
    if status_model.scope.gvec_x.positive?
      "sloping upwards"
    elsif status_model.scope.gvec_x.negative?
      "sloping downwards"
    else
      "flat"
    end
  end

  # def model_slope_line
  #   multiplyer = 10
  #   gvec_x_normalised = (status_model.scope.gvec_x * multiplyer)
  #   gvec_z_normalised = (status_model.scope.gvec_z * multiplyer)
  #   line = <<~MY_DOC
  #     <line x1='0' y1='0' stroke='green' stroke-width="3px">
  #       <animate
  #         attributeName="x2"
  #         from="0"
  #         to="#{gvec_x_normalised}"
  #         dur="1s"
  #         fill="freeze"
  #         begin="1s"
  #          />
  #       <animate
  #         attributeName="y2"
  #         from="0"
  #         to="#{gvec_z_normalised}"
  #         dur="1s"
  #         fill="freeze"
  #         begin="2s"
  #          />

  #          <animate
  #         attributeName="x1"
  #         from="0"
  #         to="#{gvec_x_normalised}"
  #         dur="1s"
  #         fill="freeze"
  #         begin="1s"
  #          />
  #       <animate
  #         attributeName="y1"
  #         from="0"
  #         to="#{gvec_z_normalised}"
  #         dur="1s"
  #         fill="freeze"
  #         begin="2s"
  #          />
  #     </line>
  #   MY_DOC

  #   line.html_safe
  # end

  def gravity_line(colour="blue")
    multiplyer = 10
    gvec_x_normalised = (status_model.scope.gvec_x * multiplyer)
    gvec_z_normalised = ((status_model.scope.gvec_z ) * multiplyer)
    line = <<~MY_DOC
      <line x1='0' y1='0' stroke='#{colour}' stroke-width="3px">
        <animate
          attributeName="x2"
          from="0"
          to="#{gvec_x_normalised}"
          dur="1s"
          fill="freeze"
          begin="1s"
           />
        <animate
          attributeName="y2"
          from="0"
          to="#{gvec_z_normalised}"
          dur="1s"
          fill="freeze"
          begin="2s"
           />
      </line>
    MY_DOC

    line.html_safe
  end

  def units
    "m/s<sup>2</sup>".html_safe
  end

  def tooltip
    return "Using default" if using_default?

    "&radic;(x^2 + z^2) = #{defined_gravity}".html_safe
  end
end
