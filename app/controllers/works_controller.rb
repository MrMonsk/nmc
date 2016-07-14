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
    @work = found_work
    verify_edit @work
  end

  def update
    @work = found_work
    new_work = work_params

    if verify_update(@work, new_work)
      @work.update_attributes(new_work)
      redirect_to work_path(@work), notice: 'Your work has been updated successfully!'
    end
  end

  def destroy
    @work = found_work
    return redirect_to works_path if @work.blank?
    if owner?(@work, 'You do not have permission to delete this work as you are not the owner')
      @work.destroy
      redirect_to works_path, notice: "Your work, #{@work.title}, has been deleted successfully"
    end
  end

  private

  def found_work
    Work.find_by_id(params[:id])
  end

  def work_params
    params.require(:work).permit(:title, :description, :instrumentation)
  end

  def owner?(work, message = 'You are not the owner of this work.')
    return true if work.user == current_user
    redirect_to work_path(work), alert: message
    false
  end

  def verify_create(work)
    if title_blank?(work)
      redirect_to new_work_path, alert: 'Oops! It looks like you forgot to enter a title.'
      return false
    elsif Work.where(['user_id = ? and title = ?', current_user.id, work[:title]]).present?
      redirect_to new_work_path, alert: 'Oops! It looks like this work already exists.'
      return false
    end
    true
  end

  def verify_edit(work)
    redirect_to works_path, alert: 'Oops! Work not found.' if work.blank?
    return true if work && owner?(work, 'Oops! You cannot edit this work since you are not the owner.')
    false
  end

  def verify_update(old_work, new_work)
    if title_blank?(new_work)
      redirect_to edit_work_path, id: old_work.id, alert: 'Oops! It looks like you forgot to enter a title.'
      return false
    end
    return true if owner?(old_work, 'Oops! You cannot edit this work since you are not the owner.')
    false
  end

  def title_blank?(work)
    work[:title].blank? ? true : false
  end
end
