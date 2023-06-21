class SessionController < ApplicationController
  #render login form
  def new
  end

  #save user info to database and ser a variable to hold the user information
  def create
    #if pasword and email are correct and user exists save user info as a cookie
    #if authentication doesn't pass redirect to login page
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      #the user information is saved globally in the session[:user] object. This is what is used to display the user's name in the nav bar
      session[:user] = user
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  #set user object to nill and redirect user to login page. When the logout button is clicked
  def destroy
    session[:user] = nil
    redirect_to '/login'
  end

end
