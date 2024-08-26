class User < ApplicationRecord
  validates :uid, :email, :name, presence: true, uniqueness: true
  has_many :cart_items, dependent: :destroy
end