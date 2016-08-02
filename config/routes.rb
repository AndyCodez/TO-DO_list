Rails.application.routes.draw do
  
  root 'static_pages#home'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

  resources :users
  resources :sessions
  resources :account_activations, only: [:edit]
  resources :lists
  resources :cards
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
