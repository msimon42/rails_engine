class Api::V1::InvoicesController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Invoice.all)
  end

  def show
    render json: InvoiceSerializer.new(Invoice.find(params[:id]))
  end

  def find
    render json: InvoiceSerializer.new(Invoice.find_by(request.query_parameters))
  end
end