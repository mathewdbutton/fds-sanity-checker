class Misc < ApplicationRecord
  belongs_to :validation_run

  def self.default
    new(gvec_x: 0, gvec_y: 0, gvec_z: -9.81)
  end
end
