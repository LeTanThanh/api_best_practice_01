module Errors
  class RecordInvalidError < ApplicationError
    def initialize error
      @error = error
      @record = @error.record

      @resource = @record.class.name.underscore
      @errors = @record.errors
    end

    def to_hash
      {
        success: false,
        errors: errors
      }
    end

    private
    
    def errors
      details = @errors.details
      fields = details.keys
      @messages = @errors.to_hash true

      fields.map do |field|
        {
          resource: @resource,
          field: field,
          code: code(field),
          message: message(field)
        }
      end
    end

    def code field
      error_code = @errors.details[field].first[:error]
      Settings.api.errors.code.to_hash[error_code]
    end

    def message field
      @messages[field].first
    end
  end
end
