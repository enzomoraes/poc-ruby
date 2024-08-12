class Brand < ApplicationRecord
  scope :active, -> (status) { where(active: status) }

  has_many :products

end
