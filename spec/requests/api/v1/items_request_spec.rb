require 'rails_helper'

RSpec.describe "Items API" do
  it "sends a list of items" do
    merchants = create_list(:merchant, 3)

    merchants.each do |merchant|
      merchant.items.create!(name: Faker::Esport.game, description: Faker::Esport.event, unit_price: Faker::Number.decimal)
      merchant.items.create!(name: Faker::Esport.game, description: Faker::Esport.event, unit_price: Faker::Number.decimal)
    end

    get '/api/v1/items'

    expect(response).to be_successful
  end
end
