class Api::V1::Items::SearchController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.search(params))
  end

  def show
    render json: ItemSerializer.new(Item.search(params).first)
  end
end
