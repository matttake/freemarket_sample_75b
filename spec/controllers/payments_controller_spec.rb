require 'rails_helper'

describe PaymentsController do
  let(:user) {create(:user)}

  describe 'POST #create' do
    before do
      login user  #ログインされている状態にする
    end
    before do
      customer = double("Payjp::customer")      # customerの変数を定義するためにモックを作成
      customer_id = "cus_23df8e7d6af0e6074465f8c82a0c"  
      card_id = "car_8bdd419be8db354163169be878b9"       

      allow(Payjp::Customer).to receive(:create).and_return(customer) #Payjp::Customerのcreateアクションが動作した時にcustomerに返す
      allow(customer).to receive(:id).and_return(customer_id)
      allow(customer).to receive(:default_card).and_return(card_id)
    end

    it "Createアクションが正常に動作するか" do
      post :create, params: {"payjp-token": "tok_xxxxxxxxxx"}
      payment = create(:payment, user_id: "1", customer_id: "cus_23df8e7d6af0e6074465f8c82a0c",card_id:"car_8bdd419be8db354163169be878b9" )
      expect(assigns(:payment).customer_id).to eq (payment.customer_id)
      expect(assigns(:payment).card_id).to eq (payment.card_id)
    end  
  end
end

