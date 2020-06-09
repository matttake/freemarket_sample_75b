class PaymentsController < ApplicationController
  before_action :authenticate_user!
  require "payjp" #Payjpの読み込み

  def index
    @payment = Payment.find_by(user_id: current_user.id)
    if @payment.present?
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(@payment.customer_id)
      @default_card_information = customer.cards.retrieve(@payment.card_id)
      @exp_month =@default_card_information.exp_month.to_s
      @exp_year = @default_card_information.exp_year.to_s.slice(2,3)
      # クレジットカードのアイコンを表示するためにカード会社を取得
      @payment_brand = @default_card_information.brand
    end
  end

  def new
  end

  def create   #Payjpとpaymentのデーベースを作成
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
    if params['payjp-token'].blank?       # 保管した顧客IDでpayjpより情報を取得
      redirect_to new_payment_path(current_user.id)
    else
      customer = Payjp::Customer.create(
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      )
      @payment = Payment.new(user_id: current_user.id, customer_id: customer.id,card_id: customer.default_card)
        if @payment.save
          redirect_to payments_path(current_user.id)
        else
          redirect_to new_payment_path(current_user.id)
        end
    end
  end

  def destroy  #PayjpとPaymentのデータベースを削除
    payment = Payment.find_by(user_id: current_user.id)
    if payment.present?
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(payment.customer_id)
      customer.delete
      payment.delete
    end
    redirect_to payments_path(current_user.id)
  end
end
