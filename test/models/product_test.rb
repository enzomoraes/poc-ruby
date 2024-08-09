require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # Test the active scope
  test "should return only active products" do
    assert_equal [products(:one)], Product.active(true).to_a
  end

  test "should return only inactive products" do
    assert_equal [products(:two)], Product.active(false).to_a
  end
end