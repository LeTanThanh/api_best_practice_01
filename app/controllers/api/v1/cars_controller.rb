class Api::V1::CarsController < Api::V1::ApplicationController
  before_action :load_car, only: %i(show update destroy)

  def create
    @car = Car.create! car_params

    render json: {
      success: true,
      message: t(".success"),
      data: {
        car: CarSerializer.new(@car)
      }
    }
  end

  def index
    @cars = Car.all

    render json: {
      success: true,
      data: {
        cars: ActiveModel::Serializer::CollectionSerializer.new(@cars)
      }
    }
  end

  def show
    render json: {
      success: true,
      data: {
        car: CarSerializer.new(@car)
      }
    }
  end

  def update
    @car.update! car_params

    render json: {
      success: true,
      message: t(".success"),
      data: {
        car: CarSerializer.new(@car)
      }
    }
  end

  def destroy
    @car.destroy

    render json: {
      success: true,
      message: t(".success"),
    }
  end

  private 

  def load_car
    @car = Car.find_by! id: params[:id]
  end

  def car_params
    params.require(:car).permit :name, :color, :code, :description
  end
end
