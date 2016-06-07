Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  resources :static_pages, only: [:index]
  resources :works, only: [:index, :show, :new, :create]
  resources :performances, only: [:index, :show, :new]
  resources :users, only: [:show]
end
