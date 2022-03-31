require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items) }
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
  end
end
