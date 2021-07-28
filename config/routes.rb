Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:create] 
      resources :subscriptions, only: [:index, :create]
      resources :customer_subscriptions, only: [:create]
      resources :tea_subscriptions, only: [:create]
      resources :teas, only: [:create]
    end
  end
end
