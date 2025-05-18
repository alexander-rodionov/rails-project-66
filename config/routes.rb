# frozen_string_literal: true

Rails.application.routes.draw do
  post '/auth/:provider', to: 'sessions#auth', as: :auth_request

  namespace :api do
    resources :checks
  end

  scope module: :web do
    root 'home#index'
    resources :repositories, only: %i[index new create show] do
      resources :checks, only: %i[show], controller: 'repositories/checks'
    end
    resources :home, only: %i[index]
  end

  get 'up' => 'rails/health#show', as: :rails_health_check

end
