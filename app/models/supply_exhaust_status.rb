class SupplyExhaustStatus
  include ActiveModel::Validations

  validate :net_flow_is_zero

  def initialize(validation_run)
    @validation_run = validation_run
  end

  def total_supply
    @total_supply ||= scope.where.not(surf_id: nil).where(surface: {volume_flow: ..0, validation_run: validation_run}).sum(:volume_flow)
  end

  def total_demand
    @total_demand ||= scope.where.not(surf_id: nil).where(surface: {volume_flow: 0.., validation_run: validation_run}).sum(:volume_flow)
  end

  def net_volume_flow
    @net_volume_flow ||= total_demand + total_supply
  end

  def units
    "m<sup>3</sup>/s".html_safe
  end

  def volume_flow_contributors
    validation_run.surfaces.where.not(volume_flow: nil)
  end

  private

  attr_reader :validation_run

  def net_flow_is_zero
    unless net_volume_flow.zero?
      errors.add(:net_volume_flow, "must be equal to 0")
    end
  end


  def scope
    validation_run.vents.includes(:surface)
  end
end
