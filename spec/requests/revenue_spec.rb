require "rails_helper"

describe "Total revenue across date range API" do
  before(:each) do
    @customer_1 = Customer.create(first_name: "Ida", last_name: "Lovelace")
    @customer_2 = Customer.create(first_name: "Lance", last_name: "Armstrong")
    @merchant_1 = Merchant.create(name: "Amazon")
    @merchant_2 = Merchant.create(name: "Tea Time all the Time")
    @merchant_3 = Merchant.create(name: "Noob Shop")
    @item_1 = Item.create(name: "Tantalizing Tumeric", description: "Wholesome.", unit_price: 12345, merchant: @merchant_1)
    @item_2 = Item.create(name: "Hydrating Hibiscus", description: "Buy less, drink more!", unit_price: 1334, merchant: @merchant_1)
    @item_3 = Item.create(name: "Peppermint Rose Rejuvination", description: "Quick jolt for your on the go mornings.", unit_price: 2589, merchant: @merchant_1)
    @item_4 = Item.create(name: "Dinosaur Tea Infuser", description: "Drop this prehistoric creature into your drink and sip.", unit_price: 2099, merchant: @merchant_2)
    @item_5 = Item.create(name: "Super Disposable Batteries", description: "Dispose at your convenience.", unit_price: 2390, merchant: @merchant_3)
    @invoice_1 = Invoice.create(status: 1, customer: @customer_1, merchant: @merchant_1)
    @invoice_2 = Invoice.create(status: 1, customer: @customer_2, merchant: @merchant_1)
    @invoice_3 = Invoice.create(status: 1, customer: @customer_1, merchant: @merchant_2)
    @invoice_4 = Invoice.create(status: 1, customer: @customer_1, merchant: @merchant_3)
    @invoice_item_1 = InvoiceItem.create(item: @item_1, invoice: @invoice_1, quantity: 1, unit_price: @item_1.unit_price)
    @invoice_item_2 = InvoiceItem.create(item: @item_2, invoice: @invoice_2, quantity: 1, unit_price: @item_2.unit_price)
    @invoice_item_3 = InvoiceItem.create(item: @item_3, invoice: @invoice_2, quantity: 1, unit_price: @item_3.unit_price)
    @invoice_item_4 = InvoiceItem.create(item: @item_1, invoice: @invoice_2, quantity: 2, unit_price: @item_1.unit_price)
    @invoice_item_5 = InvoiceItem.create(item: @item_4, invoice: @invoice_3, quantity: 45, unit_price: @item_4.unit_price)
    @invoice_item_6 = InvoiceItem.create(item: @item_5, invoice: @invoice_4, quantity: 10, unit_price: @item_5.unit_price)
    @transaction_1 = Transaction.create(credit_card_number: 4444555566667777, credit_card_expiration_date: '', result: 1, invoice: @invoice_1, created_at: Date.new(2020, 3, 10))
    @transaction_2 = Transaction.create(credit_card_number: 4444555566668888, credit_card_expiration_date: '', result: 1, invoice: @invoice_2, created_at: Date.new(2020, 3, 13))
    @transaction_3 = Transaction.create(credit_card_number: 4444555566667777, credit_card_expiration_date: '', result: 1, invoice: @invoice_3, created_at: Date.new(2020, 3, 20))
    @transaction_4 = Transaction.create(credit_card_number: 4444555566667777, credit_card_expiration_date: '', result: 1, invoice: @invoice_4, created_at: Date.new(2020, 3, 23))
  end
  it "sends a total revenue across given date range" do
    get "/api/v1/revenue?start=15 Mar 2020&end=22 Mar 2020"

    expect(response).to be_successful

    revenue = json
    expect(revenue[:data][:attributes][:revenue]).to eq(944.55)
  end
end
