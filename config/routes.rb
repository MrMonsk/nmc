Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  resources :beta_candidates, only: :create
  resources :works, only: [:index, :show, :new, :create]
  resources :performances, only: [:index, :show, :new]
end
