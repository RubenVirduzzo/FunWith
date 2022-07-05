Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', passwords: 'passwords' } 

  resources :users do
    resources :user_event_preferences
  end
  
  namespace :admin do 
    resources :tags
  end

  resources :events do
    resources :inscriptions
  end

  resources :locations

  root to: "events#index"
  get "/users/:id", to: "users#show"
  get "/users/ban/:id", to: "users#ban"
  get "/users/unban/:id", to: "users#unban"
  get "/users/follow/:id", to: "friendships#create"
  get "/users/unfollow/:id", to: "friendships#destroy"

end
