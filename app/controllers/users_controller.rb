class UsersController < ApplicationController

  before_action :ensure_log_in, only: :show

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
    else
      flash[:messages] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def show
    @user = current_user
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
