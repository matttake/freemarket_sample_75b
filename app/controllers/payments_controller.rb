class PaymentsController < ApplicationController

  require "payjp" #Payjpの読み込み

  def new
    @payment = Payment.new
  end

  def create   #Payjpとpaymentのデーベースを作成
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?       # 保管した顧客IDでpayjpより情報を取得
      redirect_to card_register_users_path(current_user.id)
    else
      customer = Payjp::Customer.create(
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      )
      @payment = Payment.new(user_id: current_user.id, customer_id: customer.id,card_id: customer.default_card)
        if @payment.save
          redirect_to card_index_users_path(current_user.id)
        else
          redirect_to card_register_users_path(current_user.id)
        end
    end
  end

  def destroy  #PayjpとPaymentのデータベースを削除
    payment = Payment.find_by(user_id: current_user.id)
    if payment.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(payment.customer_id)
      customer.delete
      payment.delete
    end
    redirect_to card_index_users_path(current_user.id)
  end
end
