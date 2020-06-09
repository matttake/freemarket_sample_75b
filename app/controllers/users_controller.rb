class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
  end
  
  def logout
  end
  
  def exhibition_item
    @items = Item.where(saler_id: current_user.id).includes([:images]).order("id DESC")
  end

  def confimation_item
    @items = Item.where(buyer_id: current_user.id).includes([:images]).order("id DESC")
  end

end
