FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Movies::HitchhikersGuideToTheGalaxy.quote }
    unit_price { rand(100..10000) }
    association :merchant
  end
end
