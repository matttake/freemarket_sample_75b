class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true,
                                    format: {
                                      with:/\A\S+@\S+\.\S+\z/
                                    }
  validates :encrypted_password, presence: true,
                                    format: {
                                      with: /\A[a-z\d]{7,100}+\z/i 
                                    }
  validates :fast_name, presence: true,
                                  format: {
                                    with: /\A[ぁ-んァ-ン一-龥]/
                                  }
  validates :last_name, presence: true,
                                  format: {
                                    with: /\A[ぁ-んァ-ン一-龥]/
                                  }
  validates :fast_name_reading, presence: true,
                                  format: {
                                    with: /\A[ァ-ヶー－]+\z/
                                  }
  validates :last_name_reading, presence: true,
                                  format: {
                                    with: /\A[ァ-ヶー－]+\z/
                                  }
  validates :birth_date, presence: true

  has_many :items
  has_many :payments
  has_many :addresses
end

# ニックネーム ---  非空白文字＠非空白文字.非空白文字
# パスワード   --- 半角英数字７文字以上100字以内
# 名前        --- 全角ひらがな、カタカナ、漢字
# 名前(よみ)   -- 全角カタカナ