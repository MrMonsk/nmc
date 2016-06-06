require 'rails_helper'

RSpec.describe WorksController, type: :controller do
  
  describe 'GET /index' do
    it 'should assign all works to @works' do
      # work = FactoryGirl.create(:work)
      get :index
      expect(assigns(:works)).to eq(Work.all)
    end
  end
  
  describe 'GET /new' do
  end
  
  describe 'POST /create' do
  end
end