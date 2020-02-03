class Api::V1::ItemInvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(Item.find(params[:item_id]).invoice_items)
  end
end
