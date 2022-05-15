class ValidationRun < ApplicationRecord
  has_many :vents
  has_many :surfaces

  def self.generate(run_id: SecureRandom.uuid)
    create(run_id: run_id)
  end
end
