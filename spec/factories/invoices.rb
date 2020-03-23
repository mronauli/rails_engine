FactoryBot.define do
  factory :invoice do
    status { rand(0..1) }
    association :customer
    association :merchant
  end
end
