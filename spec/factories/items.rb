FactoryBot.define do
  factory :item do
    name { Faker::Esport.game }
    description { Faker::Esport.event }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end
