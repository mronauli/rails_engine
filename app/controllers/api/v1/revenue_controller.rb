class Api::V1::RevenueController < ApplicationController
  def show
    result = InvoiceItem.total_revenue(params[:start], params[:end])
    output = {"data": {"id": nil, "attributes": {"revenue": result} } }
    render json: output
  end
end
