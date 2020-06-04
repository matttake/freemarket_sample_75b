require 'rails_helper'
describe Address do
  describe '#create' do
    it "first_nameがない場合は登録できないこと" do
      address = build(:address, first_name: nil)
      address.valid?
      expect(address.errors[:first_name]).to include("を入力してください")
    end

    it "first_nameが半角の場合は登録できないこと" do
      address = build(:address, first_name: "hankaku")
      address.valid?
      expect(address.errors[:first_name]).to include("は不正な値です")
    end

    it "last_nameがない場合は登録できないこと" do
      address = build(:address, last_name: nil)
      address.valid?
      expect(address.errors[:last_name]).to include("を入力してください")
    end

    it "last_nameが半角の場合は登録できないこと" do
      address = build(:address, last_name: "hankaku")
      address.valid?
      expect(address.errors[:last_name]).to include("は不正な値です")
    end

    it "first_name_readingがない場合は登録できないこと" do
      address = build(:address, first_name_reading: nil)
      address.valid?
      expect(address.errors[:first_name_reading]).to include("を入力してください")
    end

    it "first_name_readingが半角の場合は登録できないこと" do
      address = build(:address, first_name_reading: "hankaku")
      address.valid?
      expect(address.errors[:first_name_reading]).to include("は不正な値です")
    end

    it "first_name_readingがカタカナでない場合は登録できないこと" do
      address = build(:address, first_name_reading: "あああ")
      address.valid?
      expect(address.errors[:first_name_reading]).to include("は不正な値です")
    end

    it "last_name_readingがない場合は登録できないこと" do
      address = build(:address, last_name_reading: nil)
      address.valid?
      expect(address.errors[:last_name_reading]).to include("を入力してください")
    end

    it "last_name_readingが半角の場合は登録できないこと" do
      address = build(:address, last_name_reading: "hankaku")
      address.valid?
      expect(address.errors[:last_name_reading]).to include("は不正な値です")
    end

    it "last_name_readingがカタカナでない場合は登録できないこと" do
      address = build(:address, last_name_reading: "あああ")
      address.valid?
      expect(address.errors[:last_name_reading]).to include("は不正な値です")
    end

    it "zip_codeがない場合は登録できないこと" do
      address = build(:address, zip_code: nil)
      address.valid?
      expect(address.errors[:zip_code]).to include("を入力してください")
    end

    it "zip_codeはハイフンを含む７桁の数字でないと登録できないこと" do
      address = build(:address, zip_code: 111-111)
      address.valid?
      expect(address.errors[:zip_code]).to include("は不正な値です")
    end


    it "prefecturesがない場合は登録できないこと" do
      address = build(:address, prefectures: nil)
      address.valid?
      expect(address.errors[:prefectures]).to include("を入力してください")
    end

    it "cityがない場合は登録できないこと" do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end

    
  end
end
