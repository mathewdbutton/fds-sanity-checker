FactoryBot.define do
  factory :slice_file do
    validation_run { nil }
    quantity { "MyString" }
    vector { false }
    pbx { "9.99" }
    pby { "9.99" }
    pbz { "9.99" }
    char_id { "MyString" }
  end
end
