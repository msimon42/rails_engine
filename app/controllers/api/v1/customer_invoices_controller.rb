class Api::V1::CustomerInvoicesController < ApplicationController
  def index
    render json: CustomerInvoicesSerializer.new(Customer.find(params[:customer_id]))
  end
end
