class RegistrationsController < ApplicationController
  def new
  end

  def edit

  end

  def create
    @user = Register.new(user: user_params)
    if @user.save!
     session[:token] = @user.token
    else
      @error_message =  @user.errors.first
    end
  end

  def update
    @user = Register.new(user: user_params, token: session[:token])
    @error_message =  @user.errors.first unless @user.update!
  end

  private
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :image_url)
    end
end
