require "rails_helper"

describe "Items API" do
  let!(:items) { create_list(:item, 20) }
  let(:id) { items.first.id }
  describe "sends a list of items" do
  it "successfully" do
      get "/api/v1/items"

      items = json["data"]
      expect(response).to be_successful

      items = json['data']
      expect(items.count).to eq(20)
    end
  end
  it "can get one item by its id" do

    get "/api/v1/items/#{id}"

    item = json['data']

    expect(response).to be_successful
    expect(item['id'].to_i).to eq(id)
  end
   it "can create a new item" do
    merchant = create(:merchant)
    valid_attributes = { name: 'Visit Narnia', description: 'blank', unit_price: 123.45, merchant_id: merchant.id }
    post "/api/v1/items", params: valid_attributes
    item = json['data']

    expect(response).to be_successful
    expect(item['attributes']['name']).to eq('Visit Narnia')
  end
  it "can update an existing item" do
    previous_name = Item.first.name
    item_params = { name: "Super Duber Bubba Gum" }

    put "/api/v1/items/#{id}", params: item_params

    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Super Duber Bubba Gum")
  end
  it "can destroy an item" do
    expect(Item.count).to eq(20)

    delete "/api/v1/items/#{id}"

    expect(response).to be_successful
    expect(Item.count).to eq(19)
    expect{Item.find(id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
