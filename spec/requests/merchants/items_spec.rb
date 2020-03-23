require "rails_helper"

describe "A merchant's items API" do
  let!(:merchant) {create(:merchant)}
  let!(:items) { create_list(:item, 20, merchant_id: merchant.id) }
  let(:merchant_id) { merchant.id }
  let(:id) { items.first.id }
  it "sends a list of items" do
    get "/api/v1/merchants/#{merchant_id}/items"

    expect(response).to be_successful

    items = json['data']
    expect(items.count).to eq(20)
  end
  it "can get one item by its id" do
    get "/api/v1/merchants/#{merchant_id}/items/#{id}"

    item = json['data']

    expect(response).to be_successful
    expect(item['id'].to_i).to eq(id)
  end
   it "can create a new item" do
    valid_attributes = { name: 'Super Satin Sheets', description: '1000 thread', unit_price: 173.45, merchant_id: merchant_id }
    post "/api/v1/merchants/#{merchant_id}/items", params: valid_attributes
    item = json['data']

    expect(response).to be_successful
    expect(item['attributes']['name']).to eq('Super Satin Sheets')
    expect(item['relationships']['merchant']['data']['id'].to_i).to eq(merchant_id)
  end
  it "can update an existing item" do
    previous_name = Item.first.name
    item_params = { name: "Super Duber Bubba Gum" }

    put "/api/v1/merchants/#{merchant_id}/items/#{id}", params: item_params

    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Super Duber Bubba Gum")
  end
  it "can destroy an item" do
    expect(Item.count).to eq(20)

    item = Item.find_by(id: id)

    delete "/api/v1/merchants/#{merchant_id}/items/#{id}"

    expect(response).to be_successful
    expect(Item.count).to eq(19)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
