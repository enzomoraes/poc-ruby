require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      @user.uid = 999
      @user.email = 'outro@gmail.com'
      @user.name = 'usuário teste'
      post users_url, params: { user: { email: @user.email, image: @user.image, name: @user.name, uid: @user.uid } }, as: :json
    end

    assert_response :created
  end

  test "should show user" do
    get user_url(@user), as: :json
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { email: @user.email, image: @user.image, name: @user.name, uid: @user.uid } }, as: :json
    assert_response :success
  end

  test "should destroy user and associated cart_items" do

    assert_difference("User.count", -1) do
      assert_difference("CartItem.count", -1) do
        delete user_url(@user), as: :json
      end
    end

    assert_response :no_content
  end
end