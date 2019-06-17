Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :cars
      resources :users do
        collection do
          post :sign_up
          post :sign_in
          delete :sign_out
        end
      end
    end
  end
end
