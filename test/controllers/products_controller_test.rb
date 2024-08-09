require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should not get index when no active param is set" do
    get products_url, as: :json
    assert_response :unprocessable_entity
    json_response = JSON.parse(@response.body)
    assert_equal "Required parameter `active` is missing or invalid", json_response['error']
  end

  test "should not get index when active is not a boolean" do
    get products_url + "?active=asodijasi", as: :json
    assert_response :unprocessable_entity
    json_response = JSON.parse(@response.body)
    assert_equal "Required parameter `active` is missing or invalid", json_response['error']
  end

  test "should get index when active param is set" do
    get products_url + "?active=true", as: :json
    assert_response :success

    get products_url + "?active=false", as: :json
    assert_response :success

  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_url, params: { product: { description: @product.description, model: @product.model, name: @product.name, price: @product.price } }, as: :json
    end

    assert_response :created
  end

  test "should show product when active" do
    get product_url(@product), as: :json
    assert_response :success
  end

  test "should show 404 when product inactive" do
    @product = products(:two)
    get product_url(@product), as: :json
    assert_response :not_found
  end

  test "should update product" do
    patch product_url(@product), params: { product: { description: @product.description, model: @product.model, name: @product.name, price: @product.price } }, as: :json
    assert_response :success
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_url(@product), as: :json
    end

    assert_response :no_content
  end

  test "should activate product" do
    patch activate_product_url(@product)

    assert_response :success
  end

  test "should not activate product when not found" do
    @product.id = 131
    patch activate_product_url(@product)

    assert_response :not_found
  end

  test "should deactivate product" do
    patch deactivate_product_url(@product)

    assert_response :success
  end

  test "should not deactivate product when not found" do
    @product.id = 131
    patch deactivate_product_url(@product)

    assert_response :not_found
  end
end
