class ItemsController < ApplicationController
  
  before_action :set_item, only:[:show, :destroy, :confimation, :pay]
  before_action :set_confimation, only: :confimation
  before_action :set_payment, only: [:confimation, :pay]
  before_action :popular_category_set, only: :index

  def index
    @items = Item.where(buyer_id: nil).includes([:images]).order("id DESC").limit(6)
  end

  def view
    @items = Item.where(buyer_id: nil).includes([:images])
  end
  
  def show
  end
  
  def edit
  end
  
  def destroy
    # 商品削除できた場合はトップページへ、できなかった場合は商品詳細ページへ遷移する
    if @item.destroy
      flash[:notice] = "#{@item.name}を削除しました"  # 「(商品名)を削除しました」と画面上部に表示する
      redirect_to root_path
    else
      redirect_to item_path(@item)
    end
  end
  
  def confimation
    if @payment.present?
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(@payment.customer_id)
      @default_card_information = customer.cards.retrieve(@payment.card_id)
      @exp_month =@default_card_information.exp_month.to_s
      @exp_year = @default_card_information.exp_year.to_s.slice(2,3)
      @payment_brand = @default_card_information.brand   # クレジットカードのアイコンを表示するためにカード会社を取得
    end
  end

  def pay
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
    charge = Payjp::Charge.create(
      amount: @item.price,
      customer: @payment.customer_id,
      currency: 'jpy',
    )
    if @item.update(buyer_id: current_user.id)    
        flash[:notice] = "#{@item.name}を購入しました"
        redirect_to root_path
    else 
        redirect_to confimation_item_path(@item)
    end
  end

  
  # 商品出品アクション
  def exhibition
    # ↓DBから親カテゴリのみ抽出し、配列へ追加(渡辺)
    @category_parent_array = Category.where(ancestry: nil)
    
    # ↓出品ページのフォームのインスタンス生成（塚本）
    @item = Item.new
    @item.images.new
    
    
  end
  
  # ↓出品ボタン押した後の挙動（塚本）
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "#{@item.name}を出品しました"  # 「(商品名)を出品しました」と画面上部に表示する
      redirect_to root_path
    else
      @category_parent_array = Category.where(ancestry: nil)
      render :exhibition
    end
  end
  
  # ↓親カテゴリ選択後の子カテゴリ表示（渡辺）
  def get_category_children
    # 選択された親カテゴリに紐付く子カテゴリの配列を取得
    @category_children = Category.find("#{params[:parent_id]}").children
  end
  
  # 子カテゴリ選択後の孫カテゴリ表示
  def get_category_grandchildren
    # 選択された子カテゴリに紐付く孫カテゴリの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
  
  private
  def item_params
    params.require(:item).permit(:category_id,:name, :description, :stats, :delivery_charge, :delivery_origin_area, :days_until_delivery, :price,images_attributes:[:url, :_destroy, :id]).merge(user_id: current_user.id,saler_id: current_user.id )
  end

  def set_item  # itemデータの取得
    @item = Item.find(params[:id])
  end

  def set_confimation
    @image = Image.find(params[:id])
    @address = Address.find_by(user_id: current_user.id)
  end

  def set_payment
    @payment = Payment.find_by(user_id: current_user.id)
  end

  def popular_category_set  # 人気のカテゴリの取得
    popular_category = [1, 196] # レディース(1),メンズ(196)のidを挿入
    for num in popular_category do
      ancestry_category = Category.where('ancestry like?', "#{num}/%")  # 親子孫の3階層のカテゴリ情報を一括取得
      ids = []
      ancestry_category.each do |i|
        ids << i[:id]  # 親カテゴリに関連するカテゴリのidをidsに挿入
      end
      items = Item.where(category_id: ids).includes([:images]).order("id DESC").limit(6)
      instance_variable_set("@category_no#{num}", items)
    end
  end
end
