Rails.application.routes.draw do
  root 'homes#index'

  devise_for :users, controllers: { omniauth_callbacks: "callbacks" }

  resources :users, only: :show
  resources :reports

  match "/users/:id/finish_signup" => "users#finish_signup",
        via: [:get, :patch], as: :finish_signup
end
