require "rails_helper"

describe "Items search" do
  before(:each) do
    @merchant_1 = Merchant.create(name: "Amazon")
    @merchant_2 = Merchant.create(name: "Tea Time all the Time")
    @item_1 = Item.create(name: "Tantalizing Tumeric", description: "Wholesome.", unit_price: 12345, merchant: @merchant_1)
    @item_2 = Item.create(name: "Hydrating Hibiscus", description: "Buy less, drink more!", unit_price: 1334, merchant: @merchant_1)
    @item_3 = Item.create(name: "Peppermint Rose Rejuvination", description: "Quick jolt for your on the go mornings.", unit_price: 2589, merchant: @merchant_1)
    @item_4 = Item.create(name: "Dinosaur Tea Infuser", description: "Drop this prehistoric creature into your drink and sip.", unit_price: 799, merchant: @merchant_2)
    @item_5 = Item.create(name: "Pepper Spice", description: "Spice it up with this all spice.", unit_price: 599, merchant: @merchant_2)
  end
  it "can find an item by description" do
    get "/api/v1/items/find?name=tantalizing tumeric"

    item_data = json[:data]

    expect(item_data[:id].to_i).to eq(@item_1.id)
    expect(item_data[:attributes][:name]).to eq(@item_1.name)
  end
  it "can find an item by price" do

    get "/api/v1/items/find?price=123.45"

    item_data = json[:data]

    expect(item_data[:id].to_i).to eq(@item_1.id)
  end
  it "can find an item using multiple attributes" do

    get "/api/v1/items/find?name=tumeric&price=123.45"

    item_data = json[:data]

    expect(item_data[:id].to_i).to eq(@item_1.id)
  end
  it "can find an item with partial attribute search" do

    get "/api/v1/items/find_all?name=pepper"

    item_data = json[:data]

    expect(item_data.count).to eq(2)
    expect(item_data[0][:id].to_i).to eq(@item_3.id)
    expect(item_data[1][:id].to_i).to eq(@item_5.id)
  end
end
