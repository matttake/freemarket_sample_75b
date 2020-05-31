class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def confimation
  end

  # 商品出品アクション
  def exhibition
    # ↓DBから親カテゴリのみ抽出し、配列へ追加(渡辺)
    @category_parent_array = Category.where(ancestry: nil)
    
    # ↓出品ページのフォームのインスタンス生成（塚本）
    @items = Item.new
    @items.images.build

    
  end

  # ↓出品ボタン押した後の挙動（塚本）
  def create
    @items = Item.new(item_params)
    # @category_parent_array = Category.where(ancestry: nil).pluck(:name).unshift("選択してください")

    binding.pry

    if @items.save!
      redirect_to root_path
    else
      @category_parent_array = Category.where(ancestry: nil)
      render :exhibition
    end
  end
  
  # ↓親カテゴリ選択後の子カテゴリ表示（渡辺）
  def get_category_children
    # 選択された親カテゴリに紐付く子カテゴリの配列を取得
    @category_children = Category.where(name: "#{params[:parent_name]}", ancestry: nil).children
  end
  
  # 子カテゴリ選択後の孫カテゴリ表示
  def get_category_grandchildren
    # 選択された子カテゴリに紐付く孫カテゴリの配列を取得
    @category_grandchildren = Category.where("#{params[:child_id]}").children
  end


  private
 def item_params
    params.require(:item).permit(:category_id,:url, :name, :description, :stats, :delivery_charge, :delivery_origin_area, :days_until_delivery, :user_id, :price, :saler_id, :buyer_id, images_attributes:[:url, :_destroy, :id])
    #ログイン機能実装後付け加える→ .merge(user_id: current_user.id)(saler_id: current_user_id )
  end

end
