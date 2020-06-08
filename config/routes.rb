Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  } 

  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
    get "sign_out", to: "users/sessions#destroy" 
  end
  
  root to: "items#index"

  resources :items, only: [:index, :show, :create, :edit, :destroy] do
    member do
      get 'confimation'
      post 'pay'
    end

    collection do
      get 'exhibition'
      get 'view'
      # 子、孫カテゴリ登録用アクション
      get 'get_category_children',      defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end

  resources :users, only: [:show] do
    collection do
      get 'logout'
    end
  end

  resources :payments, only: [:index,:new,:create,:destroy]
  resources :addresses, only: [:new, :create, :edit, :update]
end
