Rails.application.routes.draw do

  resource :account, only: [:show] do
    resource :username, only: [:edit, :update], module: "accounts"
    # resource :email, only: [:edit, :update], module: "accounts"
    resource :password, only: [:edit, :update], module: "accounts"
  end

  devise_for :users, controllers: {
    confirmations:      'users/confirmations',
    sessions:           'users/sessions',
    passwords:          'users/passwords',
    registrations:      'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do
    patch 'users/confirm', to: 'users/confirmations#confirm'
    get 'comfirm_email', to: 'users/registrations#comfirm_email'
  end

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
    resources :profiles, only: [:update]
    get :schedules,on: :member
      resources :schedules, only: [:new, :create, :update]
    get :posts, on: :member
      resources :posts, only: [:new, :create, :update]
    get :discs, on: :member
      resources :discs, only: [:new, :create, :update]
    get :goods, on: :member
      resources :goods, only: [:new, :create, :update]
    get :movies, on: :member
      resources :movies, only: [:new, :create, :update]
    get :contacts, on: :member  
      resources :contacts, only: [:new]
      post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
      post 'contacts/back', to: 'contacts#back', as: 'back'
      get 'done', to: 'contacts#done', as: 'done'
    get :unsubscribe, on: :member
    patch :withdrawal, on: :member
    
    resources :signups do
      collection do
        get 'step1'
        get 'step2'
        get 'step3'
      end
    end
  end
  
  resources :profiles, only: [:show, :edit]

  resources :posts, only: [:show, :edit, :destroy]
  resources :discs, only: [:show, :edit, :destroy]
  resources :goods, only: [:show, :edit, :destroy]
  resources :movies, only: [:show, :edit, :destroy]
  resources :contacts, only: [:show, :create, :destroy]
  resources :prefectures, only: [:index, :show]
  resources :genres, only: [:index, :show]

  resources :schedules, only: [:show, :edit, :destroy] do
    resources :comments, only: [:create]  
  end

  root 'home#index'
end
