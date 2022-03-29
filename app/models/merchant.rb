class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of(:name)

  def num_items
    self.items.count
  end
end
