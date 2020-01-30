class Api::V1::CustomersController < ApplicationController
  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  def show
    render json: CustomerSerializer.new(Customer.find(params[:id]))
  end

  def find
    render json: CustomerSerializer.new(Customer.find_by(request.query_parameters))
  end
end
