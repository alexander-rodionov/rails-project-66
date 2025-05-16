Rails.application.routes.draw do

  scope module: :web do
    root "welcome#index"
    resources :repositories, only: %i[index]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
