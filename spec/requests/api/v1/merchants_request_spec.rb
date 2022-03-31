require 'rails_helper'

RSpec.describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)

    merchants[:data].each do |merchant|

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to eq(id.to_s)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it "has a 404 error if the merchant id is invalid" do
    merchant = create(:merchant)
    id = merchant.id
    id += 1

    get "/api/v1/merchants/#{id}"

    expect(response.status).to eq(404)
  end

  it "finds one merchant by search criteria" do
    merchant_1 = Merchant.create!(name: "Austin")
    merchant_2 = Merchant.create!(name: "Noel")

    get "/api/v1/merchants/find?name=Aus"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:attributes][:name]).to eq(merchant_1.name)
    expect(merchant[:data][:attributes][:name]).to_not eq(merchant_2.name)
  end

  it "returns null object if no match" do
    merchant_1 = Merchant.create!(name: "Austin")
    merchant_2 = Merchant.create!(name: "Noel")

    get "/api/v1/merchants/find?name=Z"

    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(merchant[:data][:error]).to eq("null")
  end
end
