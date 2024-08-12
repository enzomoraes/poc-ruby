class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :model, :active
  belongs_to :brand
end
