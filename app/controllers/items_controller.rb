class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def confimation
  end

  def exhibition
    @items = Item.new
    @items.images.build
  end

  def create
    @items = Item.new(item_params)
    # 現在はuser_idが無いから保存できない
    if @items.save
      redirect_to root_path
    else
      render :exhibition
    end
  end

  private
 def item_params
    params.require(:item).permit(:category_id,:url, :name, :description, :stats, :delivery_charge, :delivery_origin_area, :days_until_delivery, :user_id, :price, :saler_id, :buyer_id, images_attributes:[:url, :_destroy, :id])
    #ログイン機能実装後付け加える→ .merge(user_id: current_user.id)(saler_id: current_user_id )
  end

  
end
