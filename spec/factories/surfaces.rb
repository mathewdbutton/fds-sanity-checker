FactoryBot.define do
  factory :surface do
    sequence :char_id do |n|
      "surface_#{n}"
    end
  end
end
