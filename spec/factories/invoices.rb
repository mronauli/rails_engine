FactoryBot.define do
  factory :invoice do
    status { 1 }
    association :customer
    association :merchant
  end
end
