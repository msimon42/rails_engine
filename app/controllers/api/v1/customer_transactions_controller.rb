class Api::V1::CustomerTransactionsController < ApplicationController
  def index
    render json: CustomerTransactionSerializer.new(Customer.find(params[:customer_id]))
  end
end
