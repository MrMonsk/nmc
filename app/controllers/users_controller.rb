class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @works = @user.works
    @performances = @user.performances
  rescue ActiveRecord::RecordNotFound
    render text: 'user not found :/', status: :not_found
  end

  def edit
  end
end
