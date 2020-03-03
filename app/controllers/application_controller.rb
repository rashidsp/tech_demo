class ApplicationController < ActionController::Base

  before_action :set_current_user!

  def set_current_user!
   session_obj = Session.new(token: session[:token])
   @current_user = session_obj.current_user
  end

  def authenticate_user
    unless @current_user.present?
     session.delete(:token)
     redirect_to root_path
    end
  end
end
