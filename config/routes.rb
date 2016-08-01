Rails.application.routes.draw do
  
  get 'lists/new'

  get 'lists/index'

  get 'lists/show'

  root 'static_pages#home'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

  resources :users
  resources :sessions
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
