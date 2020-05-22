Rails.application.routes.draw do
  root to: 'view#index'
  root 'items#index'
end
