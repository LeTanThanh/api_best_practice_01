module Errors
  class ApplicationError < StandardError
    def initialize error, message = nil
      @message = message || error.message
    end

    def to_hash
      {
        success: false,
        message: @message
      }
    end
  end
end
