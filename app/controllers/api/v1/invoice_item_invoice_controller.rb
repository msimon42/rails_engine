class Api::V1::InvoiceItemInvoiceController < ApplicationController
  def show
    invoice = InvoiceItem.find_and_return_parent(params[:invoice_item_id], 'invoice')
    render json: InvoiceSerializer.new(invoice)
  end
end
