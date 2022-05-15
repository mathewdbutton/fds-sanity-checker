FactoryBot.define do
  factory :unmapped_name_list do
    line { "MyString" }
    validation_runs { nil }
  end
end
