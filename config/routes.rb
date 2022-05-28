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

    resources :profiles, only: [:edit, :update]
    resources :schedules do
      resources :reserves, only: [:create, :destroy] 
    end
    resources :reserves, only: [:index]
    get 'reservations', to: 'reserves#reservation'
    resources :posts
    resources :discs
    resources :goods
    resources :movies
    
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
  
  get 'goods_search', to: 'goods#search'
  get 'disc_search', to: 'discs#search'
  get 'search', to: 'searches#search'
  
  resources :contacts, only: [:show, :create, :destroy]
  resources :genres, only: [:index, :show]
  resources :prefectures, only: [:index, :show]
  
  root 'home#index'
end
