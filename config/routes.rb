Rails.application.routes.draw do
  devise_for :users

  root 'categories#index'
  resources :categories, only: [:index, :show, :new, :create, :destroy] do
    resources :expenses, only: [:index]
  end

  resources :expenses, only: [:new, :create, :destroy]
end

