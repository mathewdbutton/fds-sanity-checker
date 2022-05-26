FactoryBot.define do
  factory :device do
    orientation { "0,0,1" }
    quantity { "Gloop" }
    validation_run { nil }
    char_id { "MyString" }
  end
end
