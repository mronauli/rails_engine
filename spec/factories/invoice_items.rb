FactoryBot.define do
  factory :invoice_item do
    association :item
    association :invoice
    quantity { rand(1..10) }
    unit_price { item.unit_price }
  end
end
