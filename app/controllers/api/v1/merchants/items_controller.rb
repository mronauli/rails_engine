class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id]))
  end

  def show
    render json: ItemSerializer.new(Item.find_by(id: params[:id], merchant_id: params[:merchant_id]))
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params))
  end

  def update
    item = Item.find_by(id: params[:id], merchant_id: params[:merchant_id])
    item.update(item_params)
  end

  def destroy
    item = Item.find_by(id: params[:id], merchant_id: params[:merchant_id])
    item.delete
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
