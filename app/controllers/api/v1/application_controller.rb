class Api::V1::ApplicationController < ApplicationController
  include RescueFromError
  include AuthenticateUser

  protect_from_forgery with: :null_session
end
