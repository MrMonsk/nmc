Rails.application.routes.draw do
  get 'beta_candidates/create'

  devise_for :users
  root 'static_pages#home'
  resources :works, only: [:index, :show]
  resources :beta_candidates, only: :create
end
