class WorksController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update, :destroy]

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
    work = work_params

    if verify_create work
      current_user.works.create(work)
      redirect_to works_path, notice: 'Your work has been added successfully!'
    end
  end

  def edit
    @work = Work.find_by_id(params[:id])
    verify_edit @work
  end

  def update
    @work = Work.find_by_id(params[:id])
    work = work_params

    if verify_update @work, work
      @work.update_attributes(work)
      redirect_to work_path(@work), notice: 'Your work has been updated successfully!'
    end
  end

  def destroy
    @work = Work.find_by_id(params[:id])
    return redirect_to works_path if @work.blank?
    if owner?(@work) == false
      @work.destroy
      redirect_to works_path, notice: "Your work, #{@work.title}, has been deleted successfully"
    end
  end

  private

  def work_params
    params.require(:work).permit(:title, :description, :instrumentation)
  end

  def owner?(work)
    message = 'You are not the owner of this work.'
    return true if work.user_id == current_user.id
    redirect_to work_path(work), alert: message
    false
  end

  def verify_create(work)
    title_exists?(old_work, new_work)
    found_work = Work.where(user_id: current_user.id, title: work.title)
    return true if found_work.present?
    redirect_to new_work_path, alert: 'Oops! It looks like this work already exists.'
    false
  end

  def verify_edit(work)
    redirect_to works_path, alert: 'Oops! Performance not found.' if work.blank?
    return true if owner?(work)
    false
  end

  def verify_update(old_work, new_work)
    title_exists?(old_work, new_work)
    return true if owner?(old_work)
    false
  end

  def title_exists?(old_work, new_work)
    message = 'Oops! It looks like you forgot to enter a title.'
    redirect_to edit_work_path, id: old_work.id, alert: message if new_work[:title].blank?
  end
end
