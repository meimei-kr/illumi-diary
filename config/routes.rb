Rails.application.routes.draw do
  root "static_pages#top"
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :users, only: %i[new create]
  resources :diaries do
    member do
      get 'complete'
    end
    collection do
      get :my_diaries
    end
    resources :comments, only: %i[create show edit update destroy], shallow: true
    resources :claps, only: %i[create], shallow: true
  end
end
