Rails.application.routes.draw do
  devise_for :users
  get '/new_user', to: 'users#new', as: :new_user
  resources :likes
  resources :tweets
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "tweets#index"
  post 'tweets/:id/like', to: 'tweets#like', as: 'like_tweet'
end
