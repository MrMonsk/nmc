class PerformancesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update, :destroy]

  def index
    @performances = Performance.all
  end

  def show
    @performance = Performance.find_by_id(params[:id])
  end

  def new
    @performance = Performance.new
  end

  def create
    @performance_params = performance_params
    if verify_create(@performance_params)
      current_user.performances.create(@performance_params)
      redirect_to performances_path, notice: 'Your performance has been added successfully!'
    end
  end

  def edit
    @performance = found_performance
    verify_edit @performance
  end

  def update
    @performance = found_performance
    new_performance = performance_params

    if verify_update @performance, new_performance
      @performance.update_attributes(new_performance)
      redirect_to performance_path(id: @performance.id), notice: 'Your performance has been updated successfully!'
    end
  end

  def destroy
    @performance = found_performance
    return redirect_to performances_path if @performance.blank?
    if owner?(@performance)
      @performance.destroy
      redirect_to performances_path, notice: "Your performance, #{@performance.title}, has been deleted successfully"
    end
  end

  private

  def found_performance
    Performance.find_by_id(params[:id])
  end

  def performance_params
    params.require(:performance).permit(:title, :image, :video, :audio)
  end

  def owner?(performance)
    message = 'You are not the owner of this performance.'
    return true if performance.user_id == current_user.id
    redirect_to performance_path(performance), alert: message
    false
  end

  def verify_create(performance)
    if title_blank?(performance)
      redirect_to new_performance_path, alert: 'Oops! It looks like you forgot to enter a title.'
      return false
    elsif Performance.where(['user_id = ? and title = ?', current_user.id, performance[:title]]).present?
      redirect_to new_performance_path, alert: 'Oops! It looks like this performance already exists.'
      return false
    end
    true
  end

  def verify_edit(performance)
    redirect_to performances_path, alert: 'Oops! Performance not found.' if performance.blank?
    return true if owner?(performance)
    false
  end

  def verify_update(old_performance, new_performance)
    if title_blank?(new_performance)
      redirect_to edit_performance_path, id: old_performance.id, alert: 'Oops! It looks like you forgot to enter a title.'
      return false
    end
    return true if owner?(old_performance)
    false
  end

  def title_blank?(performance)
    return true if performance[:title].blank?
    false
  end
end
