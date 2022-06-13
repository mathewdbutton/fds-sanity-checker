# frozen_string_literal: true

class GravityStatusComponent < ViewComponent::Base
  delegate :defined_gravity, :using_default?, to: :status_model

  attr_reader :status_model, :validation_run, :origin, :text_offset, :arrow_size

  def initialize(validation_run:)
    @validation_run = validation_run
    @status_model = GravityStatus.new(validation_run)
    @origin = 250
    @text_offset = 10
    @arrow_size = 10
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

  def axis
    line = <<~LINE
    <text id="z-axis-label" x="#{origin + text_offset}" y="#{origin/2}" fill="red" font-size="0">
        <tspan>z
          <animate attributeType="CSS" attributeName="font-size" from="0" to="15" dur="0.1s" begin="z\-neg\-arrow\-anim.end" fill="freeze" />
        </tspan>
      </text>
      <polygon points="#{origin},#{origin/2 + arrow_size} 250,135 250,125" fill="red">
        <animate attributeName="points" dur="0.1s" fill="freeze"
                from="250,130 250,130, 250,125"
                begin="z\-neg.end"
                to="255,130 245,130 250,125"
                id="z-neg-arrow-anim" />
      </polygon>
      <line x1="250" y1="250" x2="250" y2="250" stroke="red">
        <animate
                attributeName="y1"
                from="250"
                to="125"
                dur="1s"
                fill="freeze"
                begin="x\-pos.begin"
                id="z-neg" />
        <animate
                attributeName="y2"
                from="250"
                to="375"
                dur="1s"
                fill="freeze"
                begin="x\-pos.begin"
                id="z-pos" />
      </line>
    LINE
    line.html_safe
  end

  def model_slope_line
    multiplyer = 10

    new_x2 = origin + ((status_model.scope.gvec_z * -1) * multiplyer)
    new_z2 = origin + ((status_model.scope.gvec_x * -1) * multiplyer)

    new_x1 = origin + ((status_model.scope.gvec_z) * multiplyer)
    new_z1 = origin + ((status_model.scope.gvec_x) * multiplyer)

    line = <<~MY_DOC
      <line x1='#{origin}' y1='#{origin}' x2='#{origin}' y2='#{origin}' stroke='green' stroke-width="3px">
        <animate
          attributeName="x2"
          from="#{origin}"
          to="#{new_x2}"
          dur="1s"
          fill="freeze"
          begin="1s"
           />
        <animate
          attributeName="y2"
          from="#{origin}"
          to="#{new_z2}"
          dur="1s"
          fill="freeze"
          begin="2s"
           />

          <animate
           attributeName="x1"
           from="#{origin}"
           to="#{new_x1}"
           dur="1s"
           fill="freeze"
           begin="1s"
            />
         <animate
           attributeName="y1"
           from="#{origin}"
           to="#{new_z1}"
           dur="1s"
           fill="freeze"
           begin="2s"
            />
      </line>
    MY_DOC

    line.html_safe
  end

  def gravity_line
    x = 2
    z = -9.81

    multiplyer = 10
    gvec_x_normalised = origin + (status_model.scope.gvec_x * multiplyer)
    gvec_z_normalised = origin + ((status_model.scope.gvec_z * -1) * multiplyer)

    line = <<~MY_DOC
      <line x1='#{origin}' y1='#{origin}' x2='#{origin}' y2='#{origin}' stroke='blue' stroke-width="3px">
        <animate
          attributeName="x2"
          from="#{origin}"
          to="#{gvec_x_normalised}"
          dur="1s"
          fill="freeze"
          begin="1s"
           />
        <animate
          attributeName="y2"
          from="#{origin}"
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
