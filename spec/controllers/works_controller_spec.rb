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
    it 'should take user to create work form' do
      user = FactoryGirl.create(:user)
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    work_params = FactoryGirl.attributes_for(:work)
    
    it 'should create a new work' do
      user = FactoryGirl.create(:user)
      sign_in user
      post :create, work: work_params
      
      expect(Work.exists?).to eq(true)
    end
  end
  
  describe 'GET /edit' do
    
    it 'should show the edit page for a work if work is found' do
      user = FactoryGirl.create(:user)
      sign_in user
      w = FactoryGirl.create(:work)
      get :edit, id: w.id
      expect(response).to have_http_status(:success)
    end
    
    it 'should return error if work not found' do
      user = FactoryGirl.create(:user)
      sign_in user
      get :edit, id: 'uwotm8'
      expect(response).to have_http_status(:not_found)
    end
  end
  
  describe 'PUT /update' do
  end
end
