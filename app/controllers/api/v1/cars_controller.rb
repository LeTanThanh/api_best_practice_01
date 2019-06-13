class Api::V1::CarsController < Api::V1::ApplicationController
  def create
  end

  def index
    @cars = Car.all
    render json: @cars
  end

  def show
  end

  def update
  end

  def destroy
  end
end
