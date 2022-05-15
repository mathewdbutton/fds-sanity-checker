class ValidationRun < ApplicationRecord
  has_many :vents
  has_many :surfaces
end
