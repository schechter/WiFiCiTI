class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      authenticated_user = user.authenticate(params[:password])
      if authenticated_user
        session[:user_id] = authenticated_user.id
        redirect_to root_path
      else
        redirect_to new_session_path
      end
    else
      render text: 'Unknown email or password- go back and try again...'
    end
  end

  def update
    session[:location] = params([:location])
    redirect_to current_user
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
