class Address < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true,
                          format:{
                            with: /\A[ぁ-んァ-ン一-龥]/
                          }
  validates :last_name, presence: true,
                          format:{
                            with: /\A[ぁ-んァ-ン一-龥]/
                          }
  validates :first_name_reading, presence: true,
                                    format: {
                                      with: /\A[ァ-ヶー－]+\z/
                                    }
  validates :last_name_reading, presence: true,
                                  format: {
                                    with: /\A[ァ-ヶー－]+\z/
                                  }
  validates :zip_code, presence: true,
                         format: {
                          with: /\A\d{3}[-]\d{4}\z/
                         }
  validates :prefectures, presence: true
  validates :city,presence: true

end

# バリデーション
# 名前        --- 全角ひらがな、カタカナ、漢字
# 名前(よみ)   --- 全角カタカナ
# 郵便番号     --- [3桁の数字]-[4桁の数字]