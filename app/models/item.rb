class Item < ApplicationRecord
  validates_presence_of :name, :description
  validates_presence_of :unit_price, numericality: { greater_than: 0 }
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  before_create do
    self.unit_price = self.unit_price / 100.0 unless self.count_decimal == 2
  end

  def self.search(params)
    where('name ILIKE :params' || 'description ILIKE :params', params: "%#{params[:description]}%", params: "%#{params[:name]}%" || :created_at == params[:created_at].to_date || :updated_at == params[:updated_at].to_date || :unit_price == params[:created_at].to_f)
  end

  def count_decimal
    self.unit_price.to_s.split('.').last.size
  end
end
