class InvoiceItemsController < ApplicationController
  before_action :set_invoice_item, only: [:show, :update, :destroy]

  # GET /invoice_items
  def index
    @invoice_items = InvoiceItem.all

    render json: @invoice_items
  end

  # GET /invoice_items/1
  def show
    render json: @invoice_item
  end

  # POST /invoice_items
  def create
    @invoice_item = InvoiceItem.new(invoice_item_params)

    if @invoice_item.save
      render json: @invoice_item, status: :created, location: @invoice_item
    else
      render json: @invoice_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /invoice_items/1
  def update
    if @invoice_item.update(invoice_item_params)
      render json: @invoice_item
    else
      render json: @invoice_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /invoice_items/1
  def destroy
    @invoice_item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice_item
      @invoice_item = InvoiceItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def invoice_item_params
      params.require(:invoice_item).permit(:item_id, :invoice_id, :quantity, :unit_price)
    end
end
