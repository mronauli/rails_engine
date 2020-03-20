FactoryBot.define do
  factory :invoice_item do
    item { nil }
    invoice { nil }
    quantity { 1 }
    unit_price {item.unit_price}
  end
end
