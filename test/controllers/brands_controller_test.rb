require "test_helper"

class BrandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @brand = brands(:one)
  end

  test "should not get index when no active param is set" do
    get brands_url, as: :json
    assert_response :unprocessable_entity
    json_response = JSON.parse(@response.body)
    assert_equal "Required parameter `active` is missing or invalid", json_response['error']
  end

  test "should not get index when active is not a boolean" do
    get brands_url + "?active=asodijasi", as: :json
    assert_response :unprocessable_entity
    json_response = JSON.parse(@response.body)
    assert_equal "Required parameter `active` is missing or invalid", json_response['error']
  end

  test "should get index when active param is set" do
    get brands_url + "?active=true", as: :json
    assert_response :success

    get brands_url + "?active=false", as: :json
    assert_response :success

  end

  test "should create brand" do
    assert_difference("Brand.count") do
      post brands_url, params: { brand: { description: @brand.description, name: @brand.name } }, as: :json
    end

    assert_response :created
  end

  test "should show brand when active" do
    get brand_url(@brand), as: :json
    assert_response :success
  end

  test "should show 404 when brand inactive" do
    @brand = brands(:two)
    get brand_url(@brand), as: :json
    assert_response :not_found
  end

  test "should update brand" do
    patch brand_url(@brand), params: { brand: { description: @brand.description, name: @brand.name } }, as: :json
    assert_response :success
  end

  test "should destroy brand" do
    assert_difference("Brand.count", -1) do
      delete brand_url(products(:three)), as: :json
    end

    assert_response :no_content
  end

  test "should not destroy brand when there are products related" do
    assert_raises(ActiveRecord::InvalidForeignKey) do
      delete brand_url(@brand), as: :json
    end
  end

  test "should activate brand" do
    patch activate_brand_url(@brand)

    assert_response :success
  end

  test "should not activate brand when not found" do
    @brand.id = 131
    patch activate_brand_url(@brand)

    assert_response :not_found
  end

  test "should deactivate brand" do
    patch deactivate_brand_url(@brand)

    assert_response :success
  end

  test "should not deactivate brand when not found" do
    @brand.id = 131
    patch deactivate_brand_url(@brand)

    assert_response :not_found
  end
end
