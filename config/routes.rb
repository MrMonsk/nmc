Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
<<<<<<< HEAD
  resources :works, :only => [:index, :show, :new, :create]
=======
  resources :works, only: [:index, :show]
>>>>>>> e36f6dfe2ccfe0f092cf330307432b0a1eb368af
end
