class PerformancesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create]

  def index
    @performances = Performance.all
  end

  def show
  end

  def new
    @performance = Performance.new
  end

  def create
    current_user.performances.create!(performance_params)
    flash[:success] = 'Your performance has been added successfully!'
    redirect_to performances_path
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique => e
    flash[:info] = e.message
    redirect_to new_performance_path
  end

  private

  def performance_params
    params.require(:performance).permit(:title, :image, :video, :audio)
  end
end
