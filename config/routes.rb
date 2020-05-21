Rails.application.routes.draw do

  root 'items#index'

  resources :users, only: [:show] do
    collection do
      get 'logout'
    end
  end

end
