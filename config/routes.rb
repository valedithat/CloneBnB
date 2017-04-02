Rails.application.routes.draw do

  root "home#index"
  get "dashboard", to: "dashboard#show"

  resources :listings, only: [:show, :index] do
    resources :reservations, only: [:new, :create]
  end
  resources :reservations, only: [:show]

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"

  put "update_host", to: "users#update"

  namespace :admin do
    get 'dashboard', to: "dashboard#show"
    get 'users', to: "users#index"
  end

  resources :users, only: [:new, :create, :edit, :update] do
    resources :reservations
    resources :messages
    resources :trips, only: [:index, :show]
    get 'listings', to: 'user/listings#index'
    get 'listings/:listing_id', to: 'user/listings#show', as: 'listing'
    get 'listings/:listing_id/edit', to: 'user/listings#edit', as: 'edit_listing'
  end
end
