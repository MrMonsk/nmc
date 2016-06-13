class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @works = Work.all
  end
  
  def edit
  end
end
