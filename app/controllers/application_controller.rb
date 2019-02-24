class ApplicationController < ActionController::Base
  before_action :check_token

  private

  def check_token
    redirect_to login_path unless session[:token].present?
  end
end
