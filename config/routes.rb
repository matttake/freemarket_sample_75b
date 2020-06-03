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
    collection do
      get 'confimation'
      get 'exhibition'
      # 子、孫カテゴリ登録用アクション
      get 'get_category_children',      defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end

  resources :users, only: [:show] do
    collection do
      get 'logout'
      get 'card_index'
      get 'card_register'
      get 'addresses'
    end
  end
end

  # items#index         --- トップページ
  # items#show          --- 商品詳細ページ
  # items#confimation   --- 商品購入確認ページ
  # items#exhibition    --- 商品出品ページ

  # users#show          --- ユーザーマイページ
  # users#logout        --- ログアウト画面
  # users#card_index    --- クレジットカード一覧ページ
  # users#card_register --- クレジットカード登録ページ
  # users#addresses     --- 送付先住所登録