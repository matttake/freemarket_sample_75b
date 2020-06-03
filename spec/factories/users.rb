FactoryBot.define do

  factory :user do
    nickname              {"ふりまたろう"}
    email                 {"aaaaa@aaa.aaa"}
    password              {"aaaaaaa"}
    password_confirmation {"aaaaaaa"}
    fast_name             {"山田"}
    last_name             {"太郎"}
    fast_name_reading     {"ヤマダ"}
    last_name_reading     {"タロウ"}
    birth_date            {"2020-1-1"}
  end

end