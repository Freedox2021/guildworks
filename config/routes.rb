Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
 post   "favorites/:post_id/create", to: "favorites#create"
 delete "favorites/:post_id/destroy", to: "favorites#destroy"


  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create, :edit]do
      member do
      get :followings
      get :followers
      get :likes
    end
    
  end
  resources :posts
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end

