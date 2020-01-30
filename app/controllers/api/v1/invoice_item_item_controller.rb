class Api::V1::InvoiceItemItemController < ApplicationController
  def show
    item = InvoiceItem.find_and_return_parent(params[:invoice_item_id], 'item')
    binding.pry
    render json: ItemSerializer.new(item)
  end
end
