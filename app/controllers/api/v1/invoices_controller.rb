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

  def find_all
    render json: InvoiceSerializer.new(Invoice.where(request.query_parameters).order(id: :asc))
  end

  def items
    render json: ItemSerializer.new(Invoice.find(params[:invoice_id]).items)
  end
end
