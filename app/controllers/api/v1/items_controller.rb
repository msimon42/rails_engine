class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def find
    render json: ItemSerializer.new(Item.find_by(request.query_parameters))
  end

  def find_all
    render json: ItemSerializer.new(Item.where(request.query_parameters).order(id: :asc))
  end

  def most_revenue
    render json: ItemSerializer.new(Item.top_n_by_revenue(params[:quantity]))
  end

  def best_day
    render json: GeneralSerializer.render_json(Item.find(params[:id]).best_day, 'best_day')
  end
end
