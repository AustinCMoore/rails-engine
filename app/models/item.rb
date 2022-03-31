class Item < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_numericality_of :unit_price

  def self.search_by_name(name)
    where("name ilike ?", "%#{name}%").order(:name)
  end

  def self.search_by_min_price(price)
    where("unit_price >= ?", price).order(:name)
  end

  def self.search_by_max_price(price)
    where("unit_price <= ?", price).order(:name)
  end

  def self.search_by_price_range(min, max)
    where("unit_price <= ? and unit_price >= ?", max, min)
  end
end
