Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: :callbacks }
  get '/new_user', to: 'users#new', as: :new_user
  resources :likes
  resources :tweets
  resources :users

  # Defines the root path route ("/")
  root "tweets#index"
  post 'tweets/:id/like', to: 'tweets#like', as: 'like_tweet'

  namespace :api do
      resources :tweets, only: [:index, :show]
  end  
end
