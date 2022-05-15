class Surface < ApplicationRecord
  validates :char_id, uniqueness: {scope: :validation_run}
  belongs_to :validation_run

  has_many :vents, ->(surface) { where(validation_run_id: surface.validation_run_id) }, primary_key: :char_id
end
