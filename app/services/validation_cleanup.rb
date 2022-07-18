class ValidationCleanup
  attr_reader :beginning_at

  def self.call(...)
    new(...).call
  end

  def initialize(beginning_at:)
    @beginning_at = beginning_at
  end

  def call
    scope.destroy_all
  end

  private

  def scope
    @scope ||= ValidationRun.where(created_at: ..beginning_at)
  end
end
