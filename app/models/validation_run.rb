class ValidationRun < ApplicationRecord
  has_many :vents
  has_many :surfaces
  has_many :unmapped_name_lists
  has_many :slice_files

  def self.generate(run_id: SecureRandom.uuid)
    create(run_id: run_id)
  end
end
