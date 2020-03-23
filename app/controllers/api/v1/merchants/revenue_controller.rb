class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    result = Merchant.my_revenue(params[:id].to_i)
    output = {"data": {"id": nil, "attributes":{"revenue": result} } }
    render json: output
  end
end
