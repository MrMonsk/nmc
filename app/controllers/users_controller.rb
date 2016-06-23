class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:following, :followers, :edit, :update, :destroy]
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @works = @user.works
  rescue ActiveRecord::RecordNotFound
    render text: 'user not found :/', status: :not_found
  end

  def edit
  end
  
  def following
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end
end
