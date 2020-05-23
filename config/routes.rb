Rails.application.routes.draw do
  # トップページ
  root to: "tops#index"

  # マージしてから修正するので一旦コメントアウト
  # root to: 'view#edit'
  # root 'items#index'
end
