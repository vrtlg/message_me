class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] # return current user (if it's already been found in the database) OR make user available if the user is logged in
  end

  def logged_in?
    !!current_user
  end
end
