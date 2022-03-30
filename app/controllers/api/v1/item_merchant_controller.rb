class Api::V1::ItemMerchantController < ApplicationController
  def index
    # binding.pry
    item = Item.find(params[:item_id])
    # binding.pry
    render json: MerchantSerializer.new(item.merchant)
  end
end
