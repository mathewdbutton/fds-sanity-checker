class ValidationRun < ApplicationRecord
  has_one_attached :fds_model

  has_many :vents
  has_many :surfaces
  has_many :unmapped_name_lists
  has_many :slice_files
  has_many :devices
  has_one :head
  has_one :misc

  def self.generate(run_id: SecureRandom.uuid)
    create(run_id: run_id)
  end
end
