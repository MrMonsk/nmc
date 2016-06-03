class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
  end
end
