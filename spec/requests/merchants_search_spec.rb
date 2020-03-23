require "rails_helper"

describe "Merchants search" do
  it "can find a merchant by name" do
    merchant_3 = Merchant.create(name: "prima")
    merchant_2 = Merchant.create(name: "Amazon Prime")
    merchant_1 = Merchant.create(name: "Amazon")
    get "/api/v1/merchants/find?name=amazon"

    merchant_data = json[:data]
    expect(merchant_data[:id].to_i).to eq(merchant_2.id)
    expect(merchant_data[:attributes][:name]).to eq(merchant_2.name)
  end
  it "can find a merchant by date it was created" do
    merchant = Merchant.create(name: "Amazon")

    get "/api/v1/merchants/find?created_at=21 Mar 2020"

    merchant_data = json[:data]
    expect(merchant_data[:id].to_i).to eq(merchant.id)
  end
  it "can find merchant by name and date" do
    merchant = Merchant.create(name: "Amazon")

    get "/api/v1/merchants/find?name=amazon&created_at=21 Mar 2020"

    merchant_data = json[:data]

    expect(merchant_data[:id].to_i).to eq(merchant.id)
  end
  it "can find all merchants with partial attributes" do
    merchant_1 = Merchant.create(name: "Amazon")
    merchant_2 = Merchant.create(name: "Amazon Prime")
    merchant_3 = Merchant.create(name: "amazonian prima")
    merchant_4 = Merchant.create(name: "prima")

    get "/api/v1/merchants/find_all?name=amazon"
    merchant_data = json[:data]
    expect(merchant_data.count).to eq(3)
    expect(merchant_data[0][:id].to_i).to eq(merchant_1.id)
    expect(merchant_data[1][:id].to_i).to eq(merchant_2.id)
    expect(merchant_data[2][:id].to_i).to eq(merchant_3.id)
  end
end
