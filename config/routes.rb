Rails.application.routes.draw do
  resources :tags
  resources :events
  resource :users

  devise_for :users
  root to: "home#index"
end
