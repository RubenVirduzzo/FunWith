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
  get "/show_subscriptions", to: "home#show_subscriptions"
  get "/show_availables", to: "home#show_availables"
  get "/show_tags", to: "home#show_tags"
  get "/show_one_tag/:id", to: "home#show_one_tag"
end
