class StaticPagesController < ApplicationController
  def index
  end

  def home
    render layout: false
  end
end
