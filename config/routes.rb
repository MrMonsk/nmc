Rails.application.routes.draw do
  get 'static_pages/about'
  devise_for :users
  root 'static_pages#home'
  resources :beta_candidates, only: :create
  resources :static_pages, only: :index
<<<<<<< HEAD
  resources :users, only: [:show]
  resources :works, only: [:index, :show, :new, :create]
  resources :performances, only: [:index, :show, :new, :create]
=======
  resources :users, only: [:show, :edit, :update]
  resources :works
>>>>>>> 4a2e11e3a2f192b66b40859a4c04c1d57047c528
end
