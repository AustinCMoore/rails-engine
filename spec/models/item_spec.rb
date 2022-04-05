require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
  end

  describe 'class methods' do
    it "#search_by_name" do
      merchant = Merchant.create!(name: "Austin")
      item_1 = merchant.items.create(name: "Ring", description: "This is jewlery", unit_price: 1000.00)
      item_2 = merchant.items.create(name: "Cat Toy", description: "This is for cats", unit_price: 0.99)
      item_3 = merchant.items.create(name: "Cat Food", description: "This is for cats", unit_price: 9.99)

      expect(Item.search_by_name("Cat")).to eq([item_3, item_2])
    end

    it "#search_by_min_price" do
      merchant = Merchant.create!(name: "Austin")
      item_1 = merchant.items.create(name: "Ring", description: "This is jewlery", unit_price: 1000.00)
      item_2 = merchant.items.create(name: "Cat Toy", description: "This is for cats", unit_price: 0.99)
      item_3 = merchant.items.create(name: "Cat Food", description: "This is for cats", unit_price: 9.99)

      expect(Item.search_by_min_price("1.00")).to eq([item_3, item_1])
    end

    it "#search_by_max_price" do
      merchant = Merchant.create!(name: "Austin")
      item_1 = merchant.items.create(name: "Ring", description: "This is jewlery", unit_price: 1000.00)
      item_2 = merchant.items.create(name: "Cat Toy", description: "This is for cats", unit_price: 0.99)
      item_3 = merchant.items.create(name: "Cat Food", description: "This is for cats", unit_price: 9.99)

      expect(Item.search_by_max_price("999.99")).to eq([item_3, item_2])
    end

    it "#search_by_price_range" do
      merchant = Merchant.create!(name: "Austin")
      item_1 = merchant.items.create(name: "Ring", description: "This is jewlery", unit_price: 1000.00)
      item_2 = merchant.items.create(name: "Cat Toy", description: "This is for cats", unit_price: 0.99)
      item_3 = merchant.items.create(name: "Cat Food", description: "This is for cats", unit_price: 9.99)

      expect(Item.search_by_price_range("1.00", "999.99")).to eq([item_3])
    end
  end
end
