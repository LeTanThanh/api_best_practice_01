class Api::V1::CarsController < Api::V1::ApplicationController
  before_action :load_car, only: %i(show update destroy)

  def create
  end

  def index
    @cars = Car.all
    render json: @cars
  end

  def show
    render json: @car
  end

  def update
  end

  def destroy
  end

  private 

  def load_car
    @car = Car.find params[:id]
  end
end
