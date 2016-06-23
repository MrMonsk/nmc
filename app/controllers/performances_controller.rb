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
    performance = performance_params

    if verify_params performance
      current_user.performances.create(performance)
      redirect_to performances_path, notice: 'Your performance has been added successfully!'
    end
  end

  private

  def performance_params
    params.require(:performance).permit(:title, :image, :video, :audio)
  end

  def verify_params(performance)
    if performance[:title].blank?
      redirect_to new_performance_path, alert: 'Oops! It looks like you forgot to enter a title.'
      return false
    elsif Performance.where(['user_id = ? and title = ?', current_user.id, performance[:title]]).present?
      redirect_to new_performance_path, alert: 'Oops! It looks like this performance already exists.'
      return false
    end

    true
  end
end
