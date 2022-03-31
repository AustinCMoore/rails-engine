class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if Merchant.exists?(params[:id])
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    else
      render :status => 404
    end
  end

  def find
    merchant = Merchant.search_for(params[:name])
    if merchant.nil?
      render json: {data: {error: :null}}
    else
      render json: MerchantSerializer.new(merchant)
    end
  end
end
