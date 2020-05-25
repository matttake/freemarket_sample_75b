Rails.application.routes.draw do

  root to: "tops#index"

  resources :itemdeta, only: [:index] 
  resources :items, only: [:index] do
    collection do
      get 'confimation'
      get 'exhibition'
    end
  end
  resources :users, only: [:show] do
    collection do
      get 'logout'
      get 'card_index'
      get 'card_register'
    end
  end
  resources :view, only: [:index, :new, :edit]
end

  # tops#index          --- トップページ
  # itemdeta#index      --- 商品詳細ページ
  # items#confimation   --- 商品購入確認ページ
  # items#exhibition    --- 商品出品ページ
  # users#show          --- ユーザーマイページ
  # users#logout        --- ログアウト画面
  # users#card_index    --- クレジットカード一覧ページ
  # users#card_register --- クレジットカード登録ページ

  # 以下のビューファイルはdeviseで元々用意されているファイルと置き換えても良いかと思います
  # view#index          --- ユーザー新規登録ページ
  # view#new            --- ログインページ
  # view#edit           --- 登録完了ページ
