class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])

    if user && user.authenticate(params[:session][:password]) #if 'user' is valid, authenticate using the password
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{user.username}"
      redirect_to root_path
    else
      flash.now[:error] = "Incorrect username/password" #flash.now so it will show up on the same page
      render 'new'
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You are now logged out"
    redirect_to login_path
  end

  private
  def logged_in_redirect
    if logged_in?
      flash[:notice] = "You are already logged in"
      redirect_to root_path
    end

  end

end
