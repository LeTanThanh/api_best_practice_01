module Errors
  class AuthenticationError < ApplicationError
    def initialize message = nil
      @message = message || I18n.t("api.v1.errors.authentication")
    end

    def to_hash
      {
        success: false,
        message: @message
      }
    end
  end
end
