class PerformancesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update]

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

  private

  def performance_params
    params.require(:performance).permit(:title, :image, :video, :audio)
  end

  def verify_create(performance)
    if performance[:title].blank?
      redirect_to new_performance_path, alert: 'Oops! It looks like you forgot to enter a title.'
      return false
    elsif Performance.where(['user_id = ? and title = ?', current_user.id, performance[:title]]).present?
      redirect_to new_performance_path, alert: 'Oops! It looks like this performance already exists.'
      return false
    end

    true
  end

  def verify_edit(performance)
    if performance.blank?
      redirect_to performances_path, alert: 'Oops! Performance not found.'
      return false
    elsif performance.user_id != current_user.id
      redirect_to performance_path, id: performance.id, alert: 'Oops! You cannot edit this performance since you are not the owner.'
      return false
    end

    true
  end

  def verify_update(old_performance, new_performance)
    if new_performance[:title].blank?
      redirect_to edit_performance_path, id: old_performance.id, alert: 'Oops! It looks like you forgot to enter a title.'
      return false
    elsif old_performance.user_id != current_user.id
      redirect_to performance_path, id: old_performance.id, alert: 'Oops! You cannot edit this performance since you are not the owner.'
      return false
    end

    true
  end
end
