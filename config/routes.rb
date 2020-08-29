Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'users/new_address', to: 'users/registrations#new_address'
    post 'users/create_address', to: 'users/registrations#create_address'
  end

  resources :users, only: [:show]

  root 'items#index'
  resources :categories, only: [:index, :show] 
  resources :items, except: :show
  #get 'items',to: 'categories/show'
  resources :creditcards, only: [:index, :new, :create, :show, :destroy] do
    member do
      post 'pay'
    end
  end
end
