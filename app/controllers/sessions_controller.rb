class SessionsController < ApplicationController
  def google_callback
    user_info = request.env['omniauth.auth']

    # Aqui você pode criar ou atualizar o usuário na sua base de dados
    user = User.find_or_create_by(uid: user_info['uid']) do |user|
      user.email = user_info['info']['email']
      user.name = user_info['info']['name']
      user.image = user_info['info']['image']
    end

    if user.persisted?
      # Gera um token JWT para o usuário
      token = encode_token(user)
      render json: { token: token }
    else
      render json: { message: 'Could not find user' }, status: :bad_request
    end
  end

  def google_auth_redirect
    redirect_uri = "#{request.base_url}/auth/google/callback" 
    client_id = ENV['GOOGLE_CLIENT_ID'] 
    scope = "https://www.googleapis.com/auth/userinfo.profile+openid+https://www.googleapis.com/auth/userinfo.email" 
    auth_url = "https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=#{client_id}&redirect_uri=#{redirect_uri}&scope=#{scope}&access_type=offline" 

    render json: { auth_url: auth_url } 
  end

  private
  
  def encode_token(user)
    payload = { name: user.name, image: user.image, id: user.id, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
