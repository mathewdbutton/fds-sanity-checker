class Surface < ApplicationRecord
  validates :char_id, uniqueness: true
end
