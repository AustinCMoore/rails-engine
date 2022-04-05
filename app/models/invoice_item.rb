class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  has_one :customer, through: :invoice
  has_many :transactions, through: :invoice
  belongs_to :item
  has_one :merchant, through: :item

  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_numericality_of :quantity
  validates_numericality_of :unit_price
end
