Rails.application.routes.draw do
  root to: "welcome#index"

  get "/auth/twitter", as: :login
  get "/logout", to: "sessions#destroy"
  get "/auth/twitter/callback", to: "sessions#create"
end
