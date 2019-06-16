module Errors
  class AuthenticateError < ApplicationError
    def initialize message = nil
      @message = message || message = I18n.t("api.v1.errors.authenticate")
    end

    def to_hash
      {
        success: false,
        message: @message
      }
    end
  end
end
