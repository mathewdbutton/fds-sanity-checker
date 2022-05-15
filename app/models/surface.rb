class Surface < ApplicationRecord
  validates :char_id, uniqueness: true

  has_many :vents, primary_key: :char_id
end
