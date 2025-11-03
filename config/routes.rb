Rails.application.routes.draw do
  devise_for :users
  get "/profile", to: "user#show"

  get "up" => "rails/health#show", as: :rails_health_check
end
