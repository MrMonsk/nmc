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
    elsif @work.user != current_user
      render text: 'You are not the composer of this work!', status: :forbidden
    end
  end
  
  def update
    @work = Work.find_by_id(params[:id])
    if current_user == @work.user 
      @work.update_attributes(work_params)
      redirect_to user_path(id: current_user.id), notice: 'work updated successfully'
    else
      render text: 'Oopsie', status: :forbidden
    end
  end

  private

  def work_params
    params.require(:work).permit(:title, :description, :instrumentation)
  end
end
