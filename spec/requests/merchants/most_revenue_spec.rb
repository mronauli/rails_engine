require "rails_helper"

describe "A merchant sorted by most to least revenue API" do
  before(:each) do
    @customer_1 = Customer.create(first_name: "Ida", last_name: "Lovelace")
    @customer_2 = Customer.create(first_name: "Lance", last_name: "Armstrong")
    @merchant_1 = Merchant.create(name: "Amazon")
    @merchant_2 = Merchant.create(name: "Tea Time all the Time")
    @item_1 = Item.create(name: "Tantalizing Tumeric", description: "Wholesome.", unit_price: 12345, merchant: @merchant_1)
    @item_2 = Item.create(name: "Hydrating Hibiscus", description: "Buy less, drink more!", unit_price: 1334, merchant: @merchant_1)
    @item_3 = Item.create(name: "Peppermint Rose Rejuvination", description: "Quick jolt for your on the go mornings.", unit_price: 2589, merchant: @merchant_1)
    @item_4 = Item.create(name: "Dinosaur Tea Infuser", description: "Drop this prehistoric creature into your drink and sip.", unit_price: 2099, merchant: @merchant_2)
    @invoice_1 = Invoice.create(status: 1, customer: @customer_1, merchant: @merchant_1)
    @invoice_2 = Invoice.create(status: 1, customer: @customer_2, merchant: @merchant_1)
    @invoice_3 = Invoice.create(status: 1, customer: @customer_1, merchant: @merchant_2)
    @invoice_item_1 = InvoiceItem.create(item: @item_1, invoice: @invoice_1, quantity: 1, unit_price: @item_1.unit_price)
    @invoice_item_2 = InvoiceItem.create(item: @item_2, invoice: @invoice_2, quantity: 1, unit_price: @item_2.unit_price)
    @invoice_item_3 = InvoiceItem.create(item: @item_3, invoice: @invoice_2, quantity: 1, unit_price: @item_3.unit_price)
    @invoice_item_4 = InvoiceItem.create(item: @item_1, invoice: @invoice_2, quantity: 2, unit_price: @item_1.unit_price)
    @invoice_item_5 = InvoiceItem.create(item: @item_4, invoice: @invoice_3, quantity: 45, unit_price: @item_4.unit_price)
    @transaction_1 = Transaction.create(credit_card_number: 4444555566667777, credit_card_expiration_date: '', result: "success", invoice: @invoice_1 )
    @transaction_2 = Transaction.create(credit_card_number: 4444555566668888, credit_card_expiration_date: '', result: "success", invoice: @invoice_2 )
    @transaction_3 = Transaction.create(credit_card_number: 4444555566667777, credit_card_expiration_date: '', result: "success", invoice: @invoice_3 )
  end
  it "sends a list of items" do
    get "/api/v1/merchants/most_revenue?quantity=3"

    expect(response).to be_successful

    merchants = json[:data]

    expect(merchants[0][:attributes][:name]).to eq(@merchant_2.name)
    expect(merchants[1][:attributes][:name]).to eq(@merchant_1.name)
    expect(merchants.count).to eq(2)
  end
end
