class Api::V1::CarsController < Api::V1::ApplicationController
  before_action :load_car, only: %i(show update destroy)

  def create
    @car = @current_user.cars.create! car_params

    render json: {
      success: true,
      message: t(".success"),
      data: CarSerializer.new(@car)
    }, status: :created
  end

  def index
    @cars = @current_user.cars

    render json: {
      success: true,
      message: t(".success"),
      data: ActiveModel::Serializer::CollectionSerializer.new(@cars)
    }, status: :ok
  end

  def show
    render json: {
      success: true,
      message: t(".success"),
      data: CarSerializer.new(@car)
    }, status: :ok
  end

  def update
    @car.update! car_params

    render json: {
      success: true,
      message: t(".success"),
      data: CarSerializer.new(@car)
    }, status: :accepted
  end

  def destroy
    @car.destroy

    render json: {
      success: true,
      message: t(".success"),
    }, status: :accepted
  end

  private 

  def load_car
    @car = Car.find_by! id: params[:id]

    raise Errors::AuthorizationError.new unless @current_user == @car.user
  end

  def car_params
    params.require(:car).permit :name, :color, :code, :description
  end
end
