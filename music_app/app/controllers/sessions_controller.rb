class SessionsController < ApplicationController

  # Write controller methods and the accompanying routes so that users can log in and log out. Should session be a singular resource?

  #CELLL = current user, ensure_logged_in, login!, logout!, logged_in?


  def current_user
    @current_user ||= user.find_by(session_token: session[:session_token])
  end

  def login(user)
    session[:session_token] = user.reset_session_token
  end

  def logout!(user)
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end

  def logged_in?
    !!current_user
  end
end
