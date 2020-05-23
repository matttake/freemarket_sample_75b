Rails.application.routes.draw do
  
  root to: 'itemdeta#index' 
  root to: 'view#edit'
  root 'items#index'
end