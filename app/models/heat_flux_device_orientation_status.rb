class HeatFluxDeviceOrientationStatus
  include ActiveModel::Validations

  validate :all_devices_are_facing_up
  validate :at_least_one_device

  def initialize(validation_run)
    @validation_run = validation_run
  end

  def scope
    @scope ||= validation_run.devices.where(quantity: "RADIATIVE HEAT FLUX")
  end

  private

  attr_reader :validation_run

  def at_least_one_device
    if scope.size.zero?
      errors.add(:base, "At least one Radiative Heat Flux device must be present")
    end
  end

  def all_devices_are_facing_up
    unless scope.where.not(orientation: "0,0,1").size.zero?
      errors.add(:base, "All Radiative Heat Flux devices must be facing up (0,0,1)")
    end
  end
end
