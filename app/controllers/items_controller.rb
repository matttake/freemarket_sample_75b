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
    # binding.pry
    if @items.save
      redirect_to root_path
    else
      render :exhibition
    end
  end


    # if @items.save
    #   # params[:images]["url"].each do |a|
    #   #   @image = @items.images.create!(url: a)
    #   # end
    #   redirect_to root_path
    # else
    #   render :exhibition
    # end
        
  # def update
  #   if @items.update(item_params)
  #     redirect_to root_path
  #   else
  #     render :edit
  #   end
  # end
  
  private
 def item_params
    params.require(:item).permit(:category_id,:url, :name, :description, :stats, :delivery_charge, :delivery_origin_area, :days_until_delivery, :user_id, :price, images_attributes:[:url, :_destroy, :id])
    #ログイン機能実装後付け加える→ .merge(user_id: current_user.id)
  end

  
end
