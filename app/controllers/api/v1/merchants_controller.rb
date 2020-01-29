class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def most_revenue
    render json: MerchantSerializer.new(Merchant.top_n_by_revenue(params[:quantity].to_i))
  end
end
