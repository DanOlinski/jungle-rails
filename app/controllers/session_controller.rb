class SessionController < ApplicationController
  def new
  end

  def create
    #if pasword and email are correct and user exists save user info as a cookie
    #if authentication doesn't pass redirect to login page
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

end
