module Errors
  class RecordNotFoundError < ApplicationError
    def initialize error, message
      @error = error
      @message = message

      @resource = @error.model.underscore
      @field = @error.primary_key
      @code = Settings.api.errors.code.not_found
    end

    def to_hash
      {
        success: false,
        errors: errors
      }
    end

    private

    def errors
      [
        {
          resource: @resource,
          field: @field,
          code: @code,
          message: @message
        }
      ]
    end
  end
end
