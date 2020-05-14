Rails.application.routes.draw do
  # get 'users/new'

  devise_for :users

  resources :books

  resources :users

  root to: 'homes#index'

  get 'home/about',to: 'homes#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
