class Api::V1::MerchantInvoicesController < ApplicationController
  def index
    render json: MerchantInvoicesSerializer.new(Merchant.find(params[:merchant_id]))
  end
end
