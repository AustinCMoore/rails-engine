require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    it "#search_for" do
      merchant_1 = Merchant.create!(name: "Austin")
      merchant_2 = Merchant.create!(name: "Noel")

      expect(Merchant.search_for("Aus")).to eq(merchant_1)
      expect(Merchant.search_for("oel")).to eq(merchant_2)
    end

    it "#top_merchants" do
      #insert test here
    end
  end

  describe 'instance methods' do
  end
end
