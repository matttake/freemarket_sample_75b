class Item < ApplicationRecord
  has_many :images  
  belongs_to :category

  belongs_to :saler, class_name: "User",foreign_key:"saler_id"
  belongs_to :buyer, class_name: "User",optional:true,foreign_key:"buyer_id"



  accepts_nested_attributes_for :images, allow_destroy: true
  validates_associated :images
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  validates :images, presence: true
  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :stats, presence: true
  validates :delivery_charge, presence: true
  validates :delivery_origin_area, presence: true
  validates :days_until_delivery, presence: true
  validates :price, presence: true
  validates :saler_id, presence: true
end
