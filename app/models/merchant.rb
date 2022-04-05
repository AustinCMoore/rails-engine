class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices


  validates_presence_of(:name)

  def self.search_for(name)
    where("name ilike ?", "%#{name}%").order(:name).first
  end

  def self.top_merchants(merchant_qty)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .where(transactions: { result: 'success' }, invoices: { status: 'shipped' })
    .group('merchants.id')
    .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .order('total_revenue DESC')
    .limit(5)
  end
end
