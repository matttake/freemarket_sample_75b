Rails.application.routes.draw do
  # トップページ
  root to: "items#confimation"

  # マージしてから修正するので一旦コメントアウト
  # root to: 'view#edit'
  # root 'items#index'
  

