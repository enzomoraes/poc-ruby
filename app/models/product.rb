class Product < ApplicationRecord
  scope :active, -> (status) { where(active: status) }

end
