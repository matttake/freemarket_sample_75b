Rails.application.routes.draw do

  root 'items#index'

  resources :users, only: [:show] do
    collection do
      get 'logout'
      get 'card_index'
      get 'card_register'
    end
  end

end
