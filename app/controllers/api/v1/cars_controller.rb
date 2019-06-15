class Api::V1::CarsController < Api::V1::ApplicationController
  before_action :load_car, only: %i(show update destroy)

  def create
    @car = Car.create! car_params

    render json: {
      success: true,
      message: "Create car success",
      data: {
        car: @car
      }
    }
  end

  def index
    @cars = Car.all

    render json: {
      success: true,
      message: "Get list cars success",
      data: {
        cars: @cars
      }
    }
  end

  def show
    render json: @car

    render json: {
      success: true,
      message: "Get car success",
      data: {
        car: @car
      }
    }
  end

  def update
    @car.update! car_params

    render json: {
      success: true,
      message: "Update car success",
      data: {
        car: @car
      }
    }
  end

  def destroy
    @car.destroy

    render json: {
      success: true,
      message: "Delete car success"
    }
  end

  private 

  def load_car
    @car = Car.find params[:id]
  end

  def car_params
    params.require(:car).permit :name, :color, :code, :description
  end
end
