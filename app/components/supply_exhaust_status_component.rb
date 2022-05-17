# frozen_string_literal: true

class SupplyExhaustStatusComponent < ViewComponent::Base
  attr_reader :validation_run
  def initialize(validation_run:)
    @validation_run = validation_run
  end

  def total_supply
    @total_supply ||= validation_run.vents.includes(:surface).where.not(surf_id: nil).where(surface: {volume_flow: ..0, validation_run: validation_run}).sum(:volume_flow)
  end

  def total_demand
    @total_demand ||= validation_run.vents.includes(:surface).where.not(surf_id: nil).where(surface: {volume_flow: 0.., validation_run: validation_run}).sum(:volume_flow)
  end

  def units
    "m<sup>3</sup>/s".html_safe
  end

  def valid?
    net_volume_flow.zero?
  end

  def box_state
    valid? ? "text-white bg-green-500" : "text-black bg-red-500"
  end

  def invalid?
    !valid
  end

  def volume_flow_contributors
    validation_run.surfaces.where.not(volume_flow: nil).includes(:vents)
  end

  def net_volume_flow
    total_demand + total_supply
  end
end
