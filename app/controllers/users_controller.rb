class UsersController < ApplicationController
  #render the new.html.erb file. Located in views/users
  def new
  end

  #handel the submission of the form
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user] = @user
      redirect_to '/'
    else
      redirect_to '/register'
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
