class ItemsController < ApplicationController
  
  before_action :set_item, only:[:show, :destroy, :confimation, :pay, :edit, :update]
  before_action :set_confimation, only: :confimation
  before_action :set_payment, only: [:confimation, :pay]
  before_action :popular_category_set, only: :index
  before_action :authenticate_user!, except: [:index, :show]
  before_action :no_purchase_by_seller, only:[:confimation, :pay]
  before_action :value_buyer_id, only: :confimation
  before_action :item_edit, only:[:edit, :update, :destroy]

  def index
    @items = Item.where(buyer_id: nil).includes([:images]).order("id DESC").limit(6)
  end

  def view
    @items = Item.where(buyer_id: nil).includes([:images]).order("id DESC")
  end
  
  def show
  end
  
  def edit
    @category_parent_array = Category.where(ancestry: nil)
    grandchild_category = @item.category
    child_category = grandchild_category.parent
    @category_parent_array = []
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
    @category_children_array = []
    Category.where(ancestry: child_category.ancestry).each do |children|
      @category_children_array << children
    end
    @category_grandchildren_array = []
    Category.where(ancestry: grandchild_category.ancestry).each do |grandchildren|
      @category_grandchildren_array << grandchildren
    end
  end
  
  def update
    if @item.update(item_params)
      flash[:notice] = "#{@item.name}の商品情報を修正しました"  
      redirect_to item_path(@item) 
    else
      flash[:notice] = "#{@item.name}の商品情報の保存に失敗しました"  
      redirect_to edit_item_path(@item) 
    end

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
      @exp_month = @default_card_information.exp_month.to_s
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

  def exhibition
    @category_parent_array = Category.where(ancestry: nil)
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "#{@item.name}を出品しました" 
      redirect_to root_path
    else
      @category_parent_array = Category.where(ancestry: nil)
      render :exhibition
    end
  end
  
  # ↓親カテゴリ選択後の子カテゴリ表示
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
    @image = Image.find_by(item_id: params[:id])
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
      items = Item.where(category_id: ids, buyer_id: nil).includes([:images]).order("id DESC").limit(6)
      instance_variable_set("@category_no#{num}", items)
    end
  end

  def no_purchase_by_seller
    if current_user.id == @item.saler_id  # 自身が出品した商品の購入ページへは遷移できず、トップページへ遷移する
      redirect_to root_path
    end
  end

  def value_buyer_id
    if @item.buyer_id.present?  # 既に商品が購入されている場合は商品の購入ページへ偏移できず、トップページへ偏移する
      redirect_to root_path
    end
  end

  def item_edit
    if current_user.id != @item.saler_id  # 自身が出品者でない場合、編集ページに偏移できず、トップページへ偏移する
      redirect_to root_path
    end
  end

end
