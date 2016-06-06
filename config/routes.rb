Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  resources :works, only: [:index, :show]
  resources :performances, only: [:index, :show, :new]
end
