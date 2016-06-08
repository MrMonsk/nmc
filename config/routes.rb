Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  resources :beta_candidates, only: :create
  resources :performances, only: [:index, :show, :new]
  resources :static_pages, only: :index
  resources :users, only: [:show, :edit, :update]
  resources :works, only: [:index, :show, :new, :create]
end
