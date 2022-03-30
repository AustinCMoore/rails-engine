class ItemSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :unit_price, :merchant_id

  # belongs_to :merchant
  # has_many :items

  # attribute :active do
  #   true
  # end
end
