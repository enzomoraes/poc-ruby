class Product < ApplicationRecord
  scope :active, -> (status) { where(active: status) }

  belongs_to :brand
  has_many :cart_items

end
