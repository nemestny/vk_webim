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
    
    user = VkontakteApi.authorize(code: params[:code])

    session[:token] = user.token
    session[:user_id] = user.user_id 

    redirect_to root_path
  end

  def destroy
    
  end
end
