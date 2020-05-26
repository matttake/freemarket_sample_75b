class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true, length: { minimum: 7 }
  validates :fast_name, presence: true
  validates :last_name, presence: true
  validates :fast_name_reading, presence: true 
  validates :last_name_reading, presence: true
  validates :birth_date, presence: true

  has_many :items
  has_many :payments
  has_many :addresses
end
