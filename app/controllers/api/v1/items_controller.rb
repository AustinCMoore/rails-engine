class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    if Item.exists?(params[:id])
      render json: ItemSerializer.new(Item.find(params[:id]))
    else
      render :status => 404
    end
  end

  def create
    if params[:item].empty?
      render :status => 404
    else
      item = Item.create(item_params)
      if item.id.nil?
        render :status => 404
      else
        render json: ItemSerializer.new(item), status: :created
      end
    end
  end

  def update
    if Item.exists?(params[:id])
      item = Item.find(params[:id])
      if item.update(item_params)
        render json: ItemSerializer.new(item)
      else
        render :status => 404
      end
    else
      render :status => 404
    end
  end

  def destroy
    if Item.exists?(params[:id])
      render json: Item.delete(params[:id])
    else
      render :status => 404
    end
  end

  def find_all
    if params[:name].present? && (params[:min_price].present? || params[:max_price].present?)
      render :status => 404
    elsif params[:min_price].present? && params[:max_price].present?
      items = Item.search_by_price_range(params[:min_price], params[:max_price])
      validate_items(items)
    elsif params[:min_price].present?
      items = Item.search_by_min_price(params[:min_price])
      validate_items(items)
    elsif params[:max_price].present?
      items = Item.search_by_max_price(params[:max_price])
      validate_items(items)
    elsif params[:name].present?
      items = Item.search_by_name(params[:name])
      validate_items(items)
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

  def validate_items(items)
    if items.empty?
      render json: {data: []}
    else
      render json: ItemSerializer.new(items)
    end
  end
end
