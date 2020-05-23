Rails.application.routes.draw do
  
  root to: 'itemdeta#index' 
  root to: 'view#edit'
  root 'items#index'
end

  root to: "tops#index"

  resources :users, only: [:show] do
    # マイページ表示用の仮アクション
    collection do
      get 'logout'
      get 'card_index'
      get 'card_register'
    end
  end

end
