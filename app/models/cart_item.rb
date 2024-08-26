class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def self.aggregate_for_user(user_id)
    items = where(user_id: user_id).includes(:product)
    aggregated_items = items.group_by(&:product_id).map do |product_id, items|
      product = items.first.product
      quantity = items.sum(&:quantity)
      {
        quantity: quantity,
        product: product,
        total: product.price * quantity
      }
    end

    total_cart = aggregated_items.sum { |item| item[:total] }

    {
      items: aggregated_items,
      total_cart: total_cart
    }
  end
end