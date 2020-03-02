class SessionsController < ApplicationController
  before_action :authenticate_user, only: [:destroy]

  def new
  end

  def forgot_password
  end

  def reset_password
    @session = Session.new(user: user_params)
    @error_message =  @session.errors.first unless @session.reset_password!
  end

  def create
     @session = Session.new(user: user_params)
     if @session.login!
      session[:token] = @session.token
     else
       @error_message =  @session.errors.first
     end
  end

  def destroy
    @session = Session.new(token: session[:token])
    if @session.revoke!
     session.delete(:token)
    else
      @error_message =  @session.errors.first
    end
    redirect_to root_path
  end

  private
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
