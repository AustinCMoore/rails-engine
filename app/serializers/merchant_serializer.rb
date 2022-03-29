class MerchantSerializer
  include JSONAPI::Serializer
  attributes :id, :name

  has_many :items

  attribute :active do
    true
  end
end
