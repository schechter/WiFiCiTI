class SessionsController < ApplicationController

  def new
    p session
  end

  def create
    user = User.find_by_email(params[:email])
    authrnticated_user = user.authenticate(params[:password])
    if authenticated_user
      session[:user_id] = authenticated_user.id
      message = "You're signed in"
      render text: message, layout: true
      redirect_to #logged in user page
    else
      redirect_to sessions_new_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to sessions_new_path
  end

  def update
  	session[:location] = params([:location])
  	redirect_to #show hotspots nearby user page
end
