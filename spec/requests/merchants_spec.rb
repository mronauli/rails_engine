require "rails_helper"

describe "Merchants API" do
  let!(:merchants) { create_list(:merchant, 10) }
  let(:merchant_id) { merchants.first.id }
  describe 'GET /merchants' do
    it "sends a list of merchants" do
      get "/api/v1/merchants"

      merchants = json['data']

      expect(response).to be_successful
      expect(merchants.count).to eq(10)
    end
  end
  describe 'GET /merchants/:id' do
    it "can get one merchant by its id" do
      get "/api/v1/merchants/#{merchant_id}"

      merchant = json['data']

      expect(response).to be_successful
      expect(merchant['id'].to_i).to eq(merchant_id)
    end
  end
  describe 'POST /merchants' do
    it "can create a new merchant" do
      valid_attributes = { name: 'Saw' }
      post "/api/v1/merchants", params: valid_attributes
      merchant = json['data']

      expect(response).to be_successful
      expect(merchant['attributes']['name']).to eq('Saw')
    end
  end
  describe 'PUT /merchants' do
    it "can update an existing merchant" do
      old_name = Merchant.first.name
      valid_attributes = { name: 'Doraemon' }

      put "/api/v1/merchants/#{merchant_id}", params: valid_attributes

      merchant = Merchant.find_by(id: merchant_id)

      expect(response).to be_successful
      expect(merchant.name).to_not eq(old_name)
      expect(merchant.name).to eq("Doraemon")
    end
  end
  it "can destroy an merchant" do

    merchant = create(:merchant)

    expect(Merchant.count).to eq(11)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(10)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
