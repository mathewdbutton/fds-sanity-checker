class Vent < ApplicationRecord
  belongs_to :surface, primary_key: :char_id, optional: true
  belongs_to :validation_run

  alias_attribute :surf_id, :surface_id
end
