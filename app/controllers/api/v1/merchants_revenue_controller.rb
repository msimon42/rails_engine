class Api::V1::MerchantsRevenueController < ApplicationController
  def show
    render json: GeneralSerializer.render_json(Invoice.revenue_by_date(params[:date]), 'total_revenue')
  end
end
