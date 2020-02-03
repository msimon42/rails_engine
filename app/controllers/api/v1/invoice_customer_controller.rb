class Api::V1::InvoiceCustomerController < ApplicationController
  def show
    render json: CustomerSerializer.new(Invoice.find(params[:invoice_id]).customer)
  end

  def best_day

  end   
end
