require "rails_helper"

describe "As item's merchant API" do
  let!(:merchant) {create(:merchant)}
  let!(:items) { create_list(:item, 20, merchant_id: merchant.id) }
  let(:id) { merchant.id }
  let(:item_id) { items.first.id }
  it "returns merchant associated with item" do
    get "/api/v1/items/#{item_id}/merchant/"

    expect(response).to be_successful

    merchant = json[:data]
    
    expect(merchant[:id].to_i).to eq(id)
  end
end
