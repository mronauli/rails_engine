class Api::V1::Merchants::SearchController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.search(params))
  end

  def show
    render json: MerchantSerializer.new(Merchant.search(params).first)
  end
end
