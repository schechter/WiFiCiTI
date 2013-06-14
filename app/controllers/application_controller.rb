class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def admin_auth
    unless current_user && current_user.admin?
      flash[:warning] = 'You are not authorized to view the page you requested'
      redirect_to root_path
    end
  end  

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end
end
