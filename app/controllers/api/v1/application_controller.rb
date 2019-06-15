class Api::V1::ApplicationController < ApplicationController
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private

  def record_not_found error
    i18n_path = params[:controller].split("/").join(".")
    message = I18n.t "#{i18n_path}.not_found"

    render json: Errors::RecordNotFoundError.new(error, message).to_hash, status: :not_found
  end

  def record_invalid error
    render json: Errors::RecordInvalidError.new(error).to_hash, status: :unprocessable_entity
  end
end
