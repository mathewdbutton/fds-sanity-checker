# frozen_string_literal: true

class SupplyExhaustStatusComponent < ViewComponent::Base
  attr_reader :validation_run, :status_model

  delegate *%i[total_supply total_demand net_volume_flow valid?], to: :status_model

  def initialize(validation_run:)
    @validation_run = validation_run
    @status_model = SupplyExhaustStatus.new(validation_run)
  end

  def units
    "m<sup>3</sup>/s".html_safe
  end

  def errors
    status_model.valid?
    status_model.errors.full_messages
  end

  def box_state
    valid? ? "text-white bg-green-500" : "text-black bg-red-500"
  end

  def volume_flow_contributors
    validation_run.surfaces.where.not(volume_flow: nil)
  end
end
