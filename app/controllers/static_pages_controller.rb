class StaticPagesController < ApplicationController
  def index
  end

  def home
    render layout: false
  end

  def about
  end
  
  def project
    render layout: false
  end
end
