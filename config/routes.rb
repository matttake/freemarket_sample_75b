Rails.application.routes.draw do

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
