class SliceFile < ApplicationRecord
  belongs_to :validation_run

  def used_plane
    [:pbx, :pby, :pbz].find do |field|
      self[field] != nil
    end
  end

  def used_plane_value
    self[used_plane]
  end
end
