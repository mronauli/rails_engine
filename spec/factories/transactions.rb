FactoryBot.define do
  factory :transaction do
    credit_card_number { "MyString" }
    credit_card_expiration_date { "MyString" }
    result { 1 }
    invoice { nil }
  end
end