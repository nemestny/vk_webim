class SessionsController < ApplicationController
  skip_before_action :check_token

  def new
    session[:state] = Digest::MD5.hexdigest(rand.to_s)
    @vk_path = VkontakteApi.authorization_url(scope: [:notify, :friends], state: session[:state])
  end

  def callback
    if session[:state] && session[:state] != params[:state]
      redirect_to root_path, alert: 'Ошибка входа'
    end
    
    vk = VkontakteApi.authorize(code: params[:code])

    session[:token] = vk.token
    session[:user_id] = vk.user_id 

    redirect_to root_path
  end

  def destroy
    session[:token] = nil
    session[:user_id] = nil

    redirect_to root_path
  end
end
