class Invoice < ApplicationRecord
  validates_presence_of :status
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  enum status: { pending: 0, shipped: 1 }
end
