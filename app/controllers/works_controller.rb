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
      redirect_to work_path(id: @work.id), notice: 'Your work has been updated successfully!'
    end
  end

  private

  def work_params
    params.require(:work).permit(:title, :description, :instrumentation)
  end

  def verify_create(work)
    if work[:title].blank?
      redirect_to new_work_path, alert: 'Oops! It looks like you forgot to enter a title.'
      return false
    elsif Work.where(['user_id = ? and title = ?', current_user.id, work[:title]]).present?
      redirect_to new_work_path, alert: 'Oops! It looks like this work already exists.'
      return false
    end

    true
  end

  def verify_edit(work)
    if work.blank?
      redirect_to works_path, alert: 'Oops! Work not found.'
      return false
    elsif work.user_id != current_user.id
      redirect_to work_path, id: work.id, alert: 'Oops! You cannot edit this work since you are not the owner.'
      return false
    end

    true
  end

  def verify_update(old_work, new_work)
    if new_work[:title].blank?
      redirect_to edit_work_path, id: old_work.id, alert: 'Oops! It looks like you forgot to enter a title.'
      return false
    elsif old_work.user_id != current_user.id
      redirect_to work_path, id: old_work.id, alert: 'Oops! You cannot edit this work since you are not the owner.'
      return false
    end

    true
  end
end
