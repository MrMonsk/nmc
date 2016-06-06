class WorksController < ApplicationController
  before_action :authenticate_user!, only: :show

  def index
    @works = Work.all
  end

  def show
  end
end
