FactoryBot.define do
  factory :validation_run do
    run_id { SecureRandom.uuid }
  end
end
