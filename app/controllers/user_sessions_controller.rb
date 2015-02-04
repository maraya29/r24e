class UserSessionsController < ApplicationController
  
  before_action :require_user, :only => :destroy

  def new
    redirect_back_or_default users_url if current_user
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default users_url
    else
      flash[:error] = "Invalid username or password. Please try again."
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default login_url
  end
end
