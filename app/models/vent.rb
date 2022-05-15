class Vent < ApplicationRecord
  belongs_to :surface, primary_key: :char_id, optional: true

  alias_attribute :surf_id, :surface_id
end
