#  最終課題_チーム開発DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|fast_name|string|null: false|
|last_name|string|null: false|
|last_name_reading|string|null: false|
|fast_name_reading|string|null: false|
|birth_date|date|null: false|
### Association
- has_many :items
- has_many :payments
- has_many :addresses


## paymentsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|
### Association
- belongs_to :user


## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|last_name|string|null: false|
|fast_name|string|null: false|
|last_name_reading|string|null: false|
|fast_name_reading|string|null: false|
|zip_code|integer|null: false|
|prefectures|string|null: false|
|city|string|null: false|
|address_line1|string|null: false|
|address_line2|string||
### Association
- belongs_to :user


## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|category_id|integer|null: false, foreign_key: true|
|name|string|null: false|
|description|text|null: false|
|condition|string|null: false|
|delivery_charge|string|null: false|
|delivery_origin_area|string|null: false|
|days_until_delivery|string|null: false|
|price|integer|null: false|
### Association
- belongs_to :user
- has_many :images
- belongs_to :category


## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false, foreign_key: true|
|url|string|null: false|
### Association
- belongs_to :item


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :items







