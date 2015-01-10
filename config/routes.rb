Rails.application.routes.draw do
  root 'homes#index'

  devise_for :users

  resources :users, only: :show
  resources :reports, only: [:index, :show, :new, :create]
end
