class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def login(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    redirect_to bands_url
  end

  def current_user
    @current_user = User.find_by({session_token: session[:session_token]})
  end

  def ensure_log_in
    return unless current_user.nil?
    flash[:messages] = "You need to be logged in to view this content."
    redirect_to new_session_url
  end

end
