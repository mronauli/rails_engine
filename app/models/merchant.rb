class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices

  def self.search(params)
    where('name ILIKE :params', params: "%#{params[:name]}%" || :created_at == params[:created_at].to_date || :updated_at == params[:updated_at].to_date)
  end

  def self.most_revenue(params)
    Merchant.joins(:invoice_items)
    .joins(:transactions)
    .where(transactions: {result: "success"})
    .select("merchants.*, SUM(invoice_items.item_id * invoice_items.quantity) AS revenue")
    .group(:id).order("revenue DESC").limit(params)
  end

  def self.most_items(params)
    Merchant.joins(:invoice_items)
    .joins(:transactions)
    .where(transactions: {result: "success"})
    .select("merchants.*, SUM(invoice_items.quantity) AS items_sold")
    .group(:id).order("items_sold DESC").limit(params)
  end

  def self.my_revenue(params)
    Merchant.joins(:invoices).joins(:invoice_items)
    .joins(:transactions).where(transactions: {result: "success"})
    .where("invoices.merchant_id = #{params}")
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end
end
