Rails.application.routes.draw do
  root to: 'view#edit'
  root 'items#index'
end
