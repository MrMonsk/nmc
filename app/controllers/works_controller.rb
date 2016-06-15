class WorksController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update]

  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by_id(params[:id])
  end

  def new
    @work = Work.new
  end

  def create
    current_user.works.create(work_params)
    redirect_to works_path, notice: 'work created successfully.'
  end
  
  def edit
    @work = Work.find_by_id(params[:id])
    if @work.blank?
      render text: 'Work not found :/', status: :not_found
    end
  end

  private

  def work_params
    params.require(:work).permit(:title, :description, :instrumentation)
  end
end
