class PerformancesController < ApplicationController
  before_action :authenticate_user!, only: :show
  
  def index
    @performances = Performance.all
  end

  def show
  end

  def new
  end
end
