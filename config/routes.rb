Rails.application.routes.draw do
  root to: 'dashboard#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :invites, only: [:new, :create]
  resources :account_transactions, only: [:new, :create]
end
