require 'rails_helper'

RSpec.describe "Item's Merchant API" do
  it "has a given item's merchant" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    item_1 = merchant_1.items.create!(name: Faker::Esport.game, description: Faker::Esport.event, unit_price: Faker::Number.decimal)
    item_2 = merchant_2.items.create!(name: Faker::Esport.game, description: Faker::Esport.event, unit_price: Faker::Number.decimal)

    get "/api/v1/items/#{item_1.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:id]).to eq(merchant_1.id.to_s)
    expect(merchant[:data][:id]).to_not eq(merchant_2.id.to_s)
  end

  it "returns 404 with a bad id" do
    merchant_1 = create(:merchant)
    item_1 = merchant_1.items.create!(name: Faker::Esport.game, description: Faker::Esport.event, unit_price: Faker::Number.decimal)
    id = item_1.id + 1

    get "/api/v1/items/#{id}/merchant"

    expect(response.status).to eq(404)
  end

  it "returns 404 with a string id" do
    merchant_1 = create(:merchant)
    item_1 = merchant_1.items.create!(name: Faker::Esport.game, description: Faker::Esport.event, unit_price: Faker::Number.decimal)
    id = "eleven"

    get "/api/v1/items/#{id}/merchant"

    expect(response.status).to eq(404)
  end
end
