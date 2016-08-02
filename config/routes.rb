Rails.application.routes.draw do
  
  root 'static_pages#home'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
  post 'new_cards' => 'cards#create'
  get 'new_item' => 'items#new'
  get 'mark_done' => 'items#mark_done'
  get 'undo' => 'items#undo'
  get 'move_card' => 'cards#move_card'
  get 'choose_list' => 'cards#choose_list'

  resources :users
  resources :sessions
  resources :account_activations, only: [:edit]
  resources :lists
  resources :cards
  resources :items, only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
