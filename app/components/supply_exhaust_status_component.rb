# frozen_string_literal: true

class SupplyExhaustStatusComponent < ViewComponent::Base
  attr_reader :validation_run, :supply_exhaust_validator

  delegate :total_supply, :total_demand, :net_volume_flow, to: :supply_exhaust_validator

  def initialize(validation_run:)
    @validation_run = validation_run
    @supply_exhaust_validator = SupplyExhaustStatus.new(validation_run)
  end

  def units
    "m<sup>3</sup>/s".html_safe
  end

  def valid?
    supply_exhaust_validator.valid?
  end

  def errors
    supply_exhaust_validator.valid?
    supply_exhaust_validator.errors.full_messages
  end

  def box_state
    valid? ? "text-white bg-green-500" : "text-black bg-red-500"
  end

  def volume_flow_contributors
    validation_run.surfaces.where.not(volume_flow: nil)
  end
end
