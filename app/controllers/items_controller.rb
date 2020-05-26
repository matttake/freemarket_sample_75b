class ItemsController < ApplicationController

  def index
  end
  
  def show
  end

  def confimation
  end

  def exhibition
    @items = Item.new
    @items.images.new
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
    params.require(:item).permit(:category_id, :name, :description, :stats, :delivery_charge, :delivery_origin_area, :days_until_delivery, :price, images_attributes: [:url])
    #ログイン機能実装後付け加える→ .merge(user_id: current_user.id)
  end
  
end
