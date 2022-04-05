class Transaction < ApplicationRecord
  belongs_to :invoice
  has_one :customer, through: :invoice
  has_one :merchant, through: :invoice
  has_many :invoice_items, through: :invoice
  has_many :items, through: :invoice_items

  validates_presence_of(:credit_card_number)
  validates_presence_of(:credit_card_expiration_date)
  validates_presence_of(:result)
end
