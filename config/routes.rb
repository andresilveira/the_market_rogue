Rails.application.routes.draw do
  resources :alerts, only: [:index, :destroy]

  namespace :alerts do
    resources :custom, except: [:index, :destroy]
  end

  resources :items, only: [:index, :show, :destroy, :update]

  get 'TalonRO/search', to: 'talon_ro#search', as: :talon_ro_search

  root 'items#index'
end
