class Item < ApplicationRecord
  belongs_to :user,optional: true
  belongs_to :category
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
