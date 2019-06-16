class Api::V1::UsersController < Api::V1::ApplicationController
  def sign_up
    @user = User.create! user_params

    render json: {
      success: true,
      message: t(".success"),
      data: UserSerializer.new(@user)
    }, status: :created
  end

  private

  def user_params
    params.require(:user).permit :email, :password, :password_confirmation
  end
end
