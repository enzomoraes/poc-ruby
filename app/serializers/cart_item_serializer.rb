class CartItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :user_id
  has_one :product
end
