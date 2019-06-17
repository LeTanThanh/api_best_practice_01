module AuthenticateUser extend ActiveSupport::Concern
  included do
    before_action :load_curent_user
  end

  private

  def load_curent_user
    @token = Token.find_by token: request.headers["X-TOKEN"]
    raise Errors::AuthenticateError.new unless @token

    @current_user = @token.user
  end
end
