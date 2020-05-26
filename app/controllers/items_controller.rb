class ItemsController < ApplicationController

  def index
  end
  
  def show
  end

  def confimation
  end

  # 商品出品アクション
  def exhibition
    # セレクトボックスの初期値
    @category_parent_array = ["選択してください"]
    # DBから親カテゴリのみ抽出し、配列へ追加
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  # 子、孫カテゴリ登録用アクション
  def get_category_children
    # 選択された親カテゴリに紐付く子カテゴリの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    # 選択された子カテゴリに紐付く孫カテゴリの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
end
