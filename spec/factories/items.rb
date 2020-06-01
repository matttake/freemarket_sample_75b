FactoryBot.define do

  factory :item do
    user_id                     {"1"}
    category_id                 {"1"}
    name                        {"abe"}
    description                 {"samplesample"}
    stats                       {"新品未使用"}
    delivery_charge             {"出品者が負担"}
    delivery_origin_area        {"東京都"}
    days_until_delivery         {"1〜2日"}
    price                       {"1000"}
    saler_id                    {"1"}
  end

  factory :image do
    url                          {"image.png"}
  end
end
