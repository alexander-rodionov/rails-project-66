# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :checks
  end

  scope module: :web do
    root 'home#index'

    scope :auth do
      post '/:provider', to: 'sessions#auth', as: :auth_request
      get '/:provider/callback', to: 'sessions#create', as: :auth_login_callback
      get :logout, to: 'sessions#destroy', as: :logout
    end

    resources :repositories, only: %i[index new create show] do
      resources :checks, only: %i[show create], controller: 'repositories/checks'
    end
    resources :home, only: %i[index]
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
  scope 'solid-queue' do
    mount SolidQueueDashboard::Engine, at: "/"
  end
end
