class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @works = @user.works
  rescue ActiveRecord::RecordNotFound
    render text: 'user not found :/', status: :not_found
  end

  def edit
  end
end
