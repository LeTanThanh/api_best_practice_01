class Api::V1::ApplicationController < ApplicationController
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  
  private

  def record_not_found error
    render json: {
      success: false,
      message: error.message
    }
  end

  def record_invalid error
    render json: {
      success: false,
      message: error.message
    }
  end
end
