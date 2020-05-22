Rails.application.routes.draw do
  root to: "tops#index"
  resources :tops do
    collection do
      get 'search'
    end
  end
  root 'items#index'
end
