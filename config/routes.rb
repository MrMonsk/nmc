Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  resources :beta_candidates, only: :create
  resources :static_pages, only: :index
  resources :users, only: [:show]
  resources :works, only: [:index, :show, :new, :create]
  resources :performances, only: [:index, :show, :new, :create]
end
