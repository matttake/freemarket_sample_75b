require 'rails_helper'
describe Item do
  describe '#create' do
  
    # 1
    it "全てのフォームが記載されていれば登録できること" do
      category = create(:category)
      user = create(:user)
      item = build(:item, category_id: category.id, saler_id: user.id)
      expect(item).to be_valid
    end

    #2
    it "user_idがない場合は登録できないこと" do
        item = build(:item, user_id: "")
        item.valid?
        expect(item.errors[:user_id]).to include("を入力してください")
    end  

    #3
    it "category_idがない場合は登録できないこと" do
        item = build(:item, category_id: "")
        item.valid?
        expect(item.errors[:category_id]).to include("を入力してください")
    end

    #4
    it "nameがない場合は登録できないこと" do
        item = build(:item, name: "")
        item.valid?
        expect(item.errors[:name]).to include("を入力してください")
    end

    #5
    it "descriptionがない場合は登録できないこと" do
        item = build(:item, description: "")
        item.valid?
        expect(item.errors[:description]).to include("を入力してください")
    end  

    #6
    it "statsがない場合は登録できないこと" do
        item = build(:item, stats: "")
        item.valid?
        expect(item.errors[:stats]).to include("を入力してください")
    end  

    #7
    it "delivery_chargeがない場合は登録できないこと" do
        item = build(:item, delivery_charge: "")
        item.valid?
        expect(item.errors[:delivery_charge]).to include("を入力してください")
    end  

    #8
    it "delivery_origin_areaがない場合は登録できないこと" do
        item = build(:item, delivery_origin_area: "")
        item.valid?
        expect(item.errors[:delivery_origin_area]).to include("を入力してください")
    end  

    #9
    it "days_until_deliveryがない場合は登録できないこと" do
        item = build(:item, days_until_delivery: "")
        item.valid?
        expect(item.errors[:days_until_delivery]).to include("を入力してください")
    end  

    #10
    it "priceがない場合は登録できないこと" do
        item = build(:item, price: "")
        item.valid?
        expect(item.errors[:price]).to include("を入力してください")
    end  

    #11
    it "saler_idがない場合は登録できないこと" do
        item = build(:item, saler_id: "")
        item.valid?
        expect(item.errors[:saler_id]).to include("を入力してください")
    end    

  end
end