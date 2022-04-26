Rails.application.routes.draw do
  namespace :admin do 
    resources :tags
  end
  resources :events
  resource :users

  devise_for :users
  root to: "home#index"

  resource :users
  get "/users/:id", to: "users#show"
  get "/users/ban/:id", to: "users#ban"
  get "/users/unban/:id", to: "users#unban"
  get "/show_events", to: "home#show_events"
  get "/show_users", to: "home#show_users"


end


