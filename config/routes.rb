Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:create] do
        resources :subscriptions, only: [:index, :create, :destroy]
      end
      resources :teas, only: [:create]
    end
  end
end
