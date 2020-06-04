FactoryBot.define do

  factory :address do
    first_name         { "山田" }
    last_name          { "太郎" }
    first_name_reading { "ヤマダ" }
    last_name_reading  { "タロウ" }
    zip_code           {123-4567}
    prefectures        {"東京都"}
    city               {"新宿区"}
  end
end
