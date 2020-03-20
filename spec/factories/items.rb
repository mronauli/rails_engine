FactoryBot.define do
  factory :item do
    name { "Coca Cola" }
    description { "Super refreshing" }
    unit_price { 32.40 }
    association :merchant
  end
end
