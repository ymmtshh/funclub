Rails.application.routes.draw do

  resource :account, only: [:show] do
    resource :username, :only => [:edit, :update], module: "accounts"
    resource :email, :only => [:edit, :update], module: "accounts"
    resource :password, :only => [:edit, :update], module: "accounts"
  end
  
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member

    get :schedules,on: :member
    
    get :posts, on: :member
    resources :posts, only: [:new, :create, :update]
    
    get :discs, on: :member
    resources :discs, only: [:new, :create, :update]
    
    get :goods, on: :member
    resources :goods, only: [:new, :create, :update]

    get :movies, on: :member
    resources :movies, only: [:new, :create, :update]

    get :contacts, on: :member
    get :unsubscribe, on: :member
    patch :withdrawal, on: :member
    resources :contacts, only: [:new]
    post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
    post 'contacts/back', to: 'contacts#back', as: 'back'
    get 'done', to: 'contacts#done', as: 'done'
  end
  
  resources :posts, only: [:show, :edit, :destroy]
  resources :discs, only: [:show, :edit, :destroy]
  resources :goods, only: [:show, :edit, :destroy]
  resources :movies, only: [:show, :edit, :destroy]
  
  resources :profiles, only: [:edit, :update]
  resources :schedules, only: [:show, :new, :edit, :create, :update, :destroy] do
    resources :comments, only: [:create]  
  end
  
  resources :contacts, only: [:show, :create, :destroy]
  
  root 'home#index'

end
