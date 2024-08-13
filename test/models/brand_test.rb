require "test_helper"

class BrandTest < ActiveSupport::TestCase
  # Test the active scope
  test "should return only active brands" do
    assert_equal [brands(:one), brands(:three)].sort, Brand.active(true).to_a.sort
  end

  test "should return only inactive brands" do
    assert_equal [brands(:two)], Brand.active(false).to_a
  end
end
