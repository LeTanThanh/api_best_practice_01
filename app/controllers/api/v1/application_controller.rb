class Api::V1::ApplicationController < ApplicationController
  include RescueFromError

  protect_from_forgery with: :null_session
end
