Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users

  resources :users,only:[:show, :edit, :update]
  resources :books
  get 'home/about' => 'homes#about'
  get 'users' => 'users#index'



   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



end