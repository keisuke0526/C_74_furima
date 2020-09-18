Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'users/new_address', to: 'users/registrations#new_address'
    post 'users/create_address', to: 'users/registrations#create_address'
    get 'index', to: 'users/registrations#index'
  end

  resources :users, only: :show


  root 'items#index'
  resources :categories, only: [:index, :show] 
  
  resources :items do
    collection do
      get 'get_category_children', defaults: {format: 'json'}
      get 'get_category_grandchildren', defaults: {format: 'json'}
    end
  end

  resources :creditcards, only: [:index, :new, :create, :show, :destroy] do
    member do
      post 'pay'
    end
  end
end
