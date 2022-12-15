# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing_page#index'
  get "/dashboard", to: "users#show"

  get '/register', to: 'users#new'
  post '/register', to: 'users#new'

  get "/login", to: "users#login_form"
  post "/login", to: "users#login_user"
  get "/logout", to: "users#logout_user"
  delete "/logout", to: "users#logout_user"

  resources :users do
    get '/discover', to: 'users#discover'
    resources :movies, only: %i[index show] do
      resources :viewing_parties
    end
  end


end
