Rails.application.routes.draw do
  # devise_for :users
  use_doorkeeper do
    skip_controllers :authorizations, :applications,
      :authorized_applications
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :products, only: [:index, :create, :destroy] do
        post :update_price, on: :member
        post :like, on: :member
      end

      resources :sales, only: [:create]
    end
  end
end
