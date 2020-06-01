require 'rails_helper'
describe User do
  describe '#create' do
    it "全ての入力欄に条件を満たす値が存在すれば登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "nicnameがない場合は登録できないこと" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "emailがない場合は登録できないこと" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "重複したemailが存在する場合は登録できないこと " do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "パスワードが6文字以上あれば登録できること" do
      user = build(:user, password: "aaaaaa", password_confirmation: "aaaaaa")
      user.valid?
      expect(user).to be_valid
    end

    it " passwordが5文字以下であれば登録できないこと " do
      user = build(:user, password: "aaaaa", password_confirmation: "aaaaa")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it "パスワードと確認が一致していないと登録できない" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "fast_nameがない場合は登録できないこと" do
      user = build(:user, fast_name: nil)
      user.valid?
      expect(user.errors[:fast_name]).to include("を入力してください")
    end

    it "fast_nameが半角の場合登録できないこと" do
      user = build(:user, fast_name: "name")
      user.valid?
      expect(user.errors[:fast_name]).to include("は不正な値です")
    end

    it "lastnameがない場合は登録できないこと" do
      user = build(:user, last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("を入力してください")
    end

    it "last_nameが半角の場合登録できないこと" do
      user = build(:user, last_name: "name")
      user.valid?
      expect(user.errors[:last_name]).to include("は不正な値です")
    end

    it "fast_name_readingがない場合は登録できないこと" do
      user = build(:user, fast_name_reading: nil)
      user.valid?
      expect(user.errors[:fast_name_reading]).to include("を入力してください")
    end

    it "fast_name_readingが半角の場合登録できないこと" do
      user = build(:user, fast_name_reading: "name")
      user.valid?
      expect(user.errors[:fast_name_reading]).to include("は不正な値です")
    end

    it 'fast_name_readingがカタカナでないと登録できないこと' do
      user = build(:user, fast_name_reading: "katakana")
      user.valid?
      expect(user.errors[:fast_name_reading]).to include("は不正な値です")
    end

    it "last_name_readingが半角の場合登録できないこと" do
      user = build(:user, last_name_reading: "name")
      user.valid?
      expect(user.errors[:last_name_reading]).to include("は不正な値です")
    end

    it "last_name_readingがない場合は登録できないこと" do
      user = build(:user, last_name_reading: nil)
      user.valid?
      expect(user.errors[:last_name_reading]).to include("を入力してください")
    end

    it 'last_name_readingがカタカナでないと登録できないこと' do
      user = build(:user, last_name_reading: "katakana")
      user.valid?
      expect(user.errors[:last_name_reading]).to include("は不正な値です")
    end

    it "birth_dateがない場合は登録できないこと" do
      user = build(:user, birth_date: nil)
      user.valid?
      expect(user.errors[:birth_date]).to include("を入力してください")
    end
  end
end