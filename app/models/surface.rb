class Surface < ApplicationRecord
  validates :char_id, uniqueness: {scope: :validation_run}
  belongs_to :validation_run

  has_many :vents, primary_key: :char_id
end
