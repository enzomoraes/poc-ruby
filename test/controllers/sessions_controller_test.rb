require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    OmniAuth.config.mock_auth[:google_oauth2] = nil
    @user_info = {
      :provider => 'google_oauth2',
      :uid => 12345,
      :info => {
        :name => "Tony Stark",
        :email => "tony@stark.com",
        :image => "http://example.com/image.jpg"
      },
    }
  end

  test "should create or find user and return token on google_callback" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(@user_info)

    # Simula a chamada da URL de callback do Google
    get '/auth/google/callback'

    user = User.find_by(uid: @user_info[:uid])

    assert user.present?
    assert_response :success
    
    # Verifique se o JSON retornado inclui o token
    json_response = JSON.parse(response.body)
    assert json_response['token'].present?
  end

  test "should return the Google auth URL on google_auth_redirect" do
    # Defina o client_id e a variável de ambiente GOOGLE_CLIENT_ID
    ENV['GOOGLE_CLIENT_ID'] = 'your_client_id_here'
    
    get '/auth/google/url'
    
    assert_response :success
    
    json_response = JSON.parse(response.body)
    assert json_response['auth_url'].present?
    assert json_response['auth_url'].include?('https://accounts.google.com/o/oauth2/auth')
    assert json_response['auth_url'].include?('client_id=your_client_id_here')
    assert json_response['auth_url'].include?('/auth/google/callback')
    assert json_response['auth_url'].include?('https://www.googleapis.com/auth/userinfo.profile+openid+https://www.googleapis.com/auth/userinfo.email')
  end
end
