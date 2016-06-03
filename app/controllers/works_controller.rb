class WorksController < ApplicationController
  def index
    @works = Work.all
  end
  
  def show
  end
  
  def new
    @work = Work.new
  end
  
  def create
    Work.create(work_params)
    redirect_to works_path, notice: 'work created successfully.'
  end
  
  private
  
  def work_params
    params.require(:work).permit(:title, :description, :instrumentation)
  end
end
