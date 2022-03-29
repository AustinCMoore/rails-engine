class ItemSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :description, :unit_price

  belongs_to :merchant
  # has_many :items

  # attribute :active do
  #   true
  # end
end
