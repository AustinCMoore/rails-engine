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

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(6)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it "can get item by its id" do
    merchant = create(:merchant)
    id = merchant.items.create!(name: Faker::Esport.game, description: Faker::Esport.event, unit_price: Faker::Number.decimal).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_an(Float)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_an(Integer)
  end

  it "has a 404 error if the merchant id is invalid" do
    merchant = create(:merchant)
    item = merchant.items.create!(name: Faker::Esport.game, description: Faker::Esport.event, unit_price: Faker::Number.decimal)
    id = item.id
    id += 1

    get "/api/v1/items/#{id}"

    expect(response.status).to eq(404)
  end

  it "has a 404 error if the merchant id is a string" do
    merchant = create(:merchant)
    item = merchant.items.create!(name: Faker::Esport.game, description: Faker::Esport.event, unit_price: Faker::Number.decimal)
    id = "one"

    get "/api/v1/items/#{id}"

    expect(response.status).to eq(404)
  end

  it "can create an item" do
    merchant_id = create(:merchant).id
    item_params = ({
                    name: 'new item',
                    description: 'this is a new item',
                    unit_price: 1.99,
                    merchant_id: merchant_id
      })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "has a 404 error if datatypes are incorrect" do
    merchant_id = create(:merchant).id
    item_params = ({
                    name: 99,
                    description: 98,
                    unit_price: "one ninety nine",
                    merchant_id: merchant_id.to_s
      })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    expect(response.status).to eq(404)
  end

  xit "has a 404 error if attributes are missing" do
    merchant_id = create(:merchant).id
    item_params = ({
      })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    expect(response.status).to eq(404)
  end

  it "can edit an item with partial data" do
    merchant = create(:merchant)
    id = merchant.items.create!(name: Faker::Esport.game, description: Faker::Esport.event, unit_price: Faker::Number.decimal).id
    previous_name = Item.last.name
    item_params = { name: "Changed Name" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Changed Name")
  end

  it "returns 404 with a bad integer id" do
    merchant = create(:merchant)
    id = merchant.items.create!(name: Faker::Esport.game, description: Faker::Esport.event, unit_price: Faker::Number.decimal).id
    previous_name = Item.last.name
    item_params = { name: "Changed Name" }
    headers = {"CONTENT_TYPE" => "application/json"}
    id += 1

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})

    expect(response.status).to eq(404)
  end

  xit "returns 404 with a bad merchant id" do
    merchant = create(:merchant)
    merchant_id = merchant.id + 1
    id = Item.create(name: Faker::Esport.game, description: Faker::Esport.event, unit_price: Faker::Number.decimal, merchant_id: merchant_id).id
    # previous_name = Item.last.name
    item_params = { name: "Changed Name" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}"

    expect(response.status).to eq(404)
  end

  it "returns 404 with a string id" do
    merchant = create(:merchant)
    merchant.items.create!(name: Faker::Esport.game, description: Faker::Esport.event, unit_price: Faker::Number.decimal).id
    previous_name = Item.last.name
    item_params = { name: "Changed Name" }
    headers = {"CONTENT_TYPE" => "application/json"}
    id = "eleven"

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})

    expect(response.status).to eq(404)
  end

  it "can delete an item" do
    merchant = create(:merchant)
    item = merchant.items.create(name: Faker::Esport.game, description: Faker::Esport.event, unit_price: Faker::Number.decimal)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "returns 404 with a bad id" do
    merchant = create(:merchant)
    item = merchant.items.create(name: Faker::Esport.game, description: Faker::Esport.event, unit_price: Faker::Number.decimal)
    id = item.id + 1
    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{id}"

    expect(Item.count).to eq(1)
    expect(response.status).to eq(404)
  end

  it "returns 404 with a string id" do
    merchant = create(:merchant)
    item = merchant.items.create(name: Faker::Esport.game, description: Faker::Esport.event, unit_price: Faker::Number.decimal)
    id = "eleven"
    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{id}"

    expect(Item.count).to eq(1)
    expect(response.status).to eq(404)
  end

  it "finds all items based on name" do
    merchant = create(:merchant)
    item_1 = merchant.items.create(name: "Ring", description: "This is jewlery", unit_price: 1000.00)
    item_2 = merchant.items.create(name: "Cat Toy", description: "This is for cats", unit_price: 0.99)
    item_3 = merchant.items.create(name: "Cat Food", description: "This is for cats", unit_price: 9.99)

    get "/api/v1/items/find_all?name=cat"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(2)
    expect(items[:data].first[:id]).to eq(item_3.id.to_s)
    expect(items[:data].last[:id]).to eq(item_2.id.to_s)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it "finds all items based on min and max price" do
    merchant = create(:merchant)
    item_1 = merchant.items.create(name: "Ring", description: "This is jewlery", unit_price: 1000.00)
    item_2 = merchant.items.create(name: "Cat Toy", description: "This is for cats", unit_price: 0.99)
    item_3 = merchant.items.create(name: "Cat Food", description: "This is for cats", unit_price: 9.99)

    get "/api/v1/items/find_all?max_price=999.99&min_price=1.00"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(1)
    expect(items[:data].first[:id]).to eq(item_3.id.to_s)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it "finds all items based on min price" do
    merchant = create(:merchant)
    item_1 = merchant.items.create(name: "Ring", description: "This is jewlery", unit_price: 1000.00)
    item_2 = merchant.items.create(name: "Cat Toy", description: "This is for cats", unit_price: 0.99)
    item_3 = merchant.items.create(name: "Cat Food", description: "This is for cats", unit_price: 9.99)

    get "/api/v1/items/find_all?min_price=1.00"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(2)
    expect(items[:data].first[:id]).to eq(item_3.id.to_s)
    expect(items[:data].last[:id]).to eq(item_1.id.to_s)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it "finds all items based on max price" do
    merchant = create(:merchant)
    item_1 = merchant.items.create(name: "Ring", description: "This is jewlery", unit_price: 1000.00)
    item_2 = merchant.items.create(name: "Cat Toy", description: "This is for cats", unit_price: 0.99)
    item_3 = merchant.items.create(name: "Cat Food", description: "This is for cats", unit_price: 9.99)

    get "/api/v1/items/find_all?max_price=999.99"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(2)
    expect(items[:data].first[:id]).to eq(item_3.id.to_s)
    expect(items[:data].last[:id]).to eq(item_2.id.to_s)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end
end
