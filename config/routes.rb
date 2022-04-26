Rails.application.routes.draw do
  namespace :admin do 
    resources :tags
  end
  resources :events
  resource :users

  devise_for :users
  root to: "home#index"
end
