class Api::V1::UsersController < Api::V1::ApplicationController
  def sign_up
    @user = User.create! user_params

    render json: {
      success: true,
      message: t(".success"),
      data: UserSerializer.new(@user)
    }, status: :created
  end

  def sign_in
    @user = User.find_by email: user_params[:email]
    raise Errors::AuthenticateError.new unless @user && @user.valid_password?(user_params[:password])
  
    @token = @user.tokens.create token: Token.generate_unique_token

    render json: {
      success: true,
      message: t(".success"),
      data: UserSerializer.new(@user, token: @token)
    }, status: :created
  end

  private

  def user_params
    params.require(:user).permit :email, :password, :password_confirmation
  end
end
