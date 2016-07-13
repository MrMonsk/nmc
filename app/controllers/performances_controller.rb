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
    performance = performance_params

    if verify_create performance
      current_user.performances.create(performance)
      redirect_to performances_path, notice: 'Your performance has been added successfully!'
    end
  end

  def edit
    @performance = Performance.find_by_id(params[:id])
    verify_edit @performance
  end

  def update
    @performance = Performance.find_by_id(params[:id])
    performance = performance_params

    if verify_update @performance, performance
      @performance.update_attributes(performance)
      redirect_to performance_path(id: @performance.id), notice: 'Your performance has been updated successfully!'
    end
  end

  def destroy
    @performance = Performance.find_by_id(params[:id])
    return redirect_to performances_path if @performance.blank?
    if owner?(@performance) == false
      @performance.destroy
      redirect_to performances_path, notice: "Your performance, #{@performance.title}, has been deleted successfully"
    end
  end

  private

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
    title_exists?(old_performance, new_performance)
    found_performance = Performance.where(user_id: current_user.id, title: performance.title)
    return true if found_performance.present?
    redirect_to new_performance_path, alert: 'Oops! It looks like this performance already exists.'
    false
  end

  def verify_edit(performance)
    redirect_to performances_path, alert: 'Oops! Performance not found.' if performance.blank?
    return true if owner?(performance)
    false
  end

  def verify_update(old_performance, new_performance)
    title_exists?(old_performance, new_performance)
    return true if owner?(old_performance)
    false
  end

  def title_exists?(old_performance, new_performance)
    message = 'Oops! It looks like you forgot to enter a title.'
    redirect_to edit_performance_path, id: old_performance.id, alert: message if new_performance[:title].blank?
  end
end
