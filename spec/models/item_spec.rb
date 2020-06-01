require 'rails_helper'
describe Item do
  describe '#create' do
    # 1
    it "全てのフォームが記載されていれば登録できること" do
      item = build(:item)
      expect(item).to be_valid
    end

    #2
    it "user_idがない場合は登録できないこと" do
        item = build(:item, user_id: "")
        item.valid?
        expect(item.errors[:user_id]).to include("can't be blank")
    end  

    #3
    it "category_idがない場合は登録できないこと" do
        item = build(:item, category_id: "")
        item.valid?
        expect(item.errors[:category_id]).to include("can't be blank")
    end

    #4
    it "nameがない場合は登録できないこと" do
        item = build(:item, name: "")
        item.valid?
        expect(item.errors[:name]).to include("can't be blank")
    end

    #5
    it "descriptionがない場合は登録できないこと" do
        item = build(:item, description: "")
        item.valid?
        expect(item.errors[:description]).to include("can't be blank")
    end  

    #6
    it "statsがない場合は登録できないこと" do
        item = build(:item, stats: "")
        item.valid?
        expect(item.errors[:stats]).to include("can't be blank")
    end  

    #7
    it "delivery_chargeがない場合は登録できないこと" do
        item = build(:item, delivery_charge: "")
        item.valid?
        expect(item.errors[:delivery_charge]).to include("can't be blank")
    end  

    #8
    it "delivery_origin_areaがない場合は登録できないこと" do
        item = build(:item, delivery_origin_area: "")
        item.valid?
        expect(item.errors[:delivery_origin_area]).to include("can't be blank")
    end  

    #9
    it "days_until_deliveryがない場合は登録できないこと" do
        item = build(:item, days_until_delivery: "")
        item.valid?
        expect(item.errors[:days_until_delivery]).to include("can't be blank")
    end  

    #10
    it "priceがない場合は登録できないこと" do
        item = build(:item, price: "")
        item.valid?
        expect(item.errors[:price]).to include("can't be blank")
    end  

    #11
    it "saler_idがない場合は登録できないこと" do
        item = build(:item, saler_id: "")
        item.valid?
        expect(item.errors[:saler_id]).to include("can't be blank")
    end  


    it "imageがない場合は登録できないこと" do
      image = build(:image, url: "")
      image.valid?
      expect(image.errors[:url]).to include("can't be blank")
  end  

  end
end