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
    get :discs, on: :member
    get :goods, on: :member
    get :movies, on: :member
    get :contacts, on: :member
    get :unsubscribe, on: :member
    patch :withdrawal, on: :member
    resources :contacts, only: [:new]
    post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
    post 'contacts/back', to: 'contacts#back', as: 'back'
    get 'done', to: 'contacts#done', as: 'done'
  end
  
  resources :profiles, only: [:edit, :update]

  resources :schedules, only: [:show, :new, :edit, :create, :update, :destroy] do
    resources :comments, only: [:create]  
  end
  
  resources :posts, only: [:show, :new, :edit, :create, :update, :destroy]
  resources :discs, only: [:show, :new, :edit, :create, :update, :destroy]
  resources :goods, only: [:show, :new, :edit, :create, :update, :destroy]
  resources :movies, only: [:show, :new, :edit, :create, :update, :destroy]
  resources :contacts, only: [:show, :create, :destroy]
  
  root 'home#index'

end
