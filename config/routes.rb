Rails.application.routes.draw do
  devise_for :users
  resource :users
  
  namespace :admin do 
    resources :tags
  end
  
  resources :events do
    resources :inscriptions
  end

  root to: "home#index"
  get "/users/:id", to: "users#show"
  get "/users/ban/:id", to: "users#ban"
  get "/users/unban/:id", to: "users#unban"
  get "/show_events", to: "home#show_events"
  get "/show_users", to: "home#show_users"
end
