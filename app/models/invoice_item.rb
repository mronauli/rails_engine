class InvoiceItem < ApplicationRecord
  extend SearchAttributes
  belongs_to :item
  belongs_to :invoice
  validates_presence_of :quantity
  validates_presence_of :unit_price, numericality: { greater_than: 0 }

  before_create do
    self.unit_price = (self.unit_price / 100.0) unless self.count_decimal == 2
  end

  def self.total_revenue(start_date, end_date)
    InvoiceItem.joins(:invoice)
    .joins("INNER JOIN transactions ON transactions.invoice_id = invoices.id")
    .where(transactions: {result: 1})
    .where("transactions.created_at BETWEEN ? AND ?", start_date,  end_date)
    .sum('unit_price * quantity')
  end

  def count_decimal
    self.unit_price.to_s.split('.').last.size
  end
end
