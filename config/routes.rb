Rails.application.routes.draw do
  # トップページ
  root to: "tops#index"

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
