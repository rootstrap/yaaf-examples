Rails.application.routes.draw do
  root to: 'dashboard#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :invites, only: [:new, :create]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :invites, only: [:create]
    end
  end
end
