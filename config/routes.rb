Rails.application.routes.draw do
  devise_for :users
  resource :user, only: [ :update, :destroy ] do
    get "/profile", to: "users#edit", as: :profile, on: :collection
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
