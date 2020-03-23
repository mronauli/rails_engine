require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe "before_create" do
    it "can convert integer to decimal" do
      merchant = Merchant.create(name: "Amazon")
      item = Item.new(name: "Tantalizing Tumeric", description: "Wholesome.", unit_price: 12345, merchant: merchant)
      item.save
      expect(item.unit_price).to eq(123.45)
    end
  end
end
