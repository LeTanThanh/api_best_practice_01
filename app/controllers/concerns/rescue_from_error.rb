module RescueFromError extend ActiveSupport::Concern
  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    # need to check again
    # rescue_from StandardError, with: :standard_error

    rescue_from Errors::AuthenticationError, with: :authentication_error
    rescue_from Errors::AuthorizationError, with: :authorization_error
  end

  private

  def record_not_found error
    i18n_path = params[:controller].split("/").join(".")
    message = I18n.t "#{i18n_path}.not_found"

    render json: Errors::RecordNotFoundError.new(error, message).to_hash, status: :not_found
  end

  def record_invalid error
    i18n_path = params[:controller].split("/").join(".") << ".#{params[:action]}"
    message = I18n.t "#{i18n_path}.fail"

    render json: Errors::RecordInvalidError.new(error, message).to_hash, status: :unprocessable_entity
  end

  def authentication_error error
    render json: error.to_hash, status: :unauthorized
  end

  def authorization_error error
    render json: error.to_hash, status: :forbidden
  end

  def standard_error error
    render json: Errors::ApplicationError.new(error).to_hash, status: :internal_server_error
  end
end
