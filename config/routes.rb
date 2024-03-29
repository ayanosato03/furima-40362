Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :users, only: [:show]
  resources :items, only: [:index, :new, :create,:show, :edit,:update,:destroy] do
   resources :orders, only: [:index, :new, :create]
   end
  end
  
  