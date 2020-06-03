class ItemsController < ApplicationController

  def index
  end
  
  def show
  end

  def confimation
    @payment = Payment.find_by(user_id: current_user.id)
    if @payment.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@payment.customer_id)
      @default_card_information = customer.cards.retrieve(@payment.card_id)
      @exp_month =@default_card_information.exp_month.to_s
      @exp_year = @default_card_information.exp_year.to_s.slice(2,3)
      # クレジットカードのアイコンを表示するためにカード会社を取得
      @payment_brand = @default_card_information.brand 
    end
  end

  def exhibition
  end

end
