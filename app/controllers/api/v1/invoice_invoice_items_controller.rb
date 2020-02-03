class Api::V1::InvoiceInvoiceItemsController < ApplicationController
  def show
    render json: InvoiceItemSerializer.new(Invoice.find(params[:invoice_id]).invoice_items.order(id: :desc))
  end
end
