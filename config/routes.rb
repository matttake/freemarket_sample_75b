Rails.application.routes.draw do

  devise_for :users
  root to: 'itemdeta#index' 
  
  # 一旦、自分(貫山)の作ったビュー、ファイル最下部にまとめました
#   root to: 'view#edit'
#   root 'items#index'
# end

#   root to: "tops#index"

  # マージしてから修正するので一旦コメントアウト
  # root to: 'view#edit'
  # root 'items#index'
  
  
  resources :users, only: [:show] do
    # マイページ表示用の仮アクション
    collection do
      get 'logout'
      get 'card_index'
      get 'card_register'
    end
  end

end


# itemdeta#index --- 商品詳細ページ
# view#index --- 新規登録画面
# view#new --- ログイン画面
# view#edit --- 登録完了画面
