Rails.application.routes.draw do
  root to: "welcome#index"

  get "/auth/twitter", as: :login
  get "/logout", to: "sessions#destroy"
  get "/auth/twitter/callback", to: "sessions#create"
  get "/profile", to: "users#show"
  post 'unfollow', to: 'users#unfollow'
  post 'favorites', to: 'users#favorite'
  post 'replies', to: 'users#reply'

  resources :tweets, only: [:create]
  post 'retweets', to: 'tweets#retweet'

end
