class Api::V1::CustomerInvoicesController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Customer.find(params[:customer_id]).invoices)
  end
end
