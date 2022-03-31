class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of(:name)

  def self.search_for(name)
    where("name ilike ?", "%#{name}%").order(:name).first
  end
end
