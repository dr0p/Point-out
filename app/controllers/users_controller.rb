class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      #redirect_to root_url, :notice => "Signed up!"
      #redirect_to issues_url
      redirect_to log_in_url
    else
      render "new"
    end
  end

end
