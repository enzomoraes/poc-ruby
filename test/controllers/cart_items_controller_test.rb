require "test_helper"

class CartItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart_item = cart_items(:one)
    @user = users(:one)
  end

  test "should get index with aggregated items" do
    get cart_items_url(user_id: @user.id), as: :json
    assert_response :success
    
    json_response = JSON.parse(@response.body)
    assert_instance_of Array, json_response
    assert_equal CartItem.where(user_id: @user.id).group(:product_id).count.keys.size, json_response.size
    # Add more specific assertions about the structure of aggregated items
  end

  test "should not get index without user_id" do
    get cart_items_url, as: :json
    assert_response :bad_request
  end

  test "should create new cart_item" do
    new_user = User.create!(uid: "1234567890", name: "New User", email: "newuser@example.com")
    new_product = Product.create!(name: "New Product", price: 9.99, brand: brands(:one))

    assert_difference("CartItem.count", 1) do
      post cart_items_url, params: { 
        cart_item: { 
          user_id: new_user.id, 
          product_id: new_product.id,
          quantity: 2 
        } 
      }, as: :json
    end
    assert_response :created
    assert_equal 2, JSON.parse(@response.body)["quantity"]
  end

  test "should update existing cart_item" do
    assert_no_difference("CartItem.count") do
      post cart_items_url, params: { 
        cart_item: { 
          user_id: @user.id, 
          product_id: @cart_item.product_id,
          quantity: 3 
        } 
      }, as: :json
    end
    assert_response :created
    assert_equal 3, JSON.parse(@response.body)["quantity"]
  end

  test "should remove cart_item when quantity is zero" do
    assert_difference("CartItem.count", -1) do
      post cart_items_url, params: { 
        cart_item: { 
          user_id: @user.id, 
          product_id: @cart_item.product_id,  # Use an existing cart item
          quantity: 0 
        } 
      }, as: :json
    end
    assert_response :no_content
  end

  test "should destroy all cart items for user" do
    assert_difference("CartItem.count", -CartItem.where(user_id: @user.id).count) do
      delete cart_items_url, params: { user_id: @user.id }, as: :json
    end
    assert_response :no_content
  end

  test "should return not found error for non-existent user on index" do
    get cart_items_url(user_id: 999999), as: :json
    assert_response :not_found
    assert_equal({ "error" => "User with id 999999 not found" }, JSON.parse(@response.body))
  end

  test "should return not found error for non-existent user on destroy" do
    delete cart_items_url(user_id: 999999), as: :json
    assert_response :not_found
    assert_equal({ "error" => "User with id 999999 not found" }, JSON.parse(@response.body))
  end
end