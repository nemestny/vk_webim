class HomeController < ApplicationController
  def index
    vk = VkontakteApi::Client.new(session[:token])

    fields = [:first_name, :last_name, :screen_name, :photo]
    
    @user = vk.users.get(uid: session[:user_id], fields: fields).first

    p @user 

    @friends = vk.friends.get(fields: fields).items.sample(5)
  end
end
