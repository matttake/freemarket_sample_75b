Rails.application.routes.draw do
  root to: "tops#index"
  root to: 'view#edit'
  # トップページ用
  root 'items#index'
end
