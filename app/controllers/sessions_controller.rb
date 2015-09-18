class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(session_params[:email],session_params[:password])
    if @user.nil?
      flash[:messages] = "Incorrect login. Please try again!"
      redirect_to new_session_url
    else
      login(@user)
    end
  end

  def destroy
    current_user.reset_session_token!
    flash[:messages] = "You have been logged out."
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end

end
