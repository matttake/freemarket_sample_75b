class ItemsController < ApplicationController

  def index
  end
  
  def show
  end

  def confimation
  end

  # 商品出品アクション
  def exhibition
    # # DBから親カテゴリのみ抽出し、配列へ追加
    @category_parent_array = Category.where(ancestry: nil).pluck(:name).unshift("選択してください")
  end

  # 親カテゴリ選択後の子カテゴリ表示
  def get_category_children
    # 選択された親カテゴリに紐付く子カテゴリの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  # 子カテゴリ選択後の孫カテゴリ表示
  def get_category_grandchildren
    # 選択された子カテゴリに紐付く孫カテゴリの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
end
