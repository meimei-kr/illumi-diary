# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development? # http://localhost:3000/letter_opener でメールを見れるようになる

  root 'static_pages#top'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  post 'guest_login', to: 'user_sessions#guest_login'
  resources :users, only: %i[new create update destroy]
  resources :diaries do
    member do
      get 'complete'
    end
    collection do
      get :my_diaries
    end
    resources :comments, only: %i[show create edit update destroy]
    resources :claps, only: %i[create], shallow: true
  end
  resource :profile, only: %i[show edit update] do
    collection do
      get 'edit_password'
      patch 'update_password'
    end
  end
  resources :password_resets, only: %i[new create edit update]
  get 'oauth/callback', to: 'oauth_login_api#callback'
  get 'oauth/:provider', to: 'oauth_login_api#oauth', as: :auth_at_provider
end
