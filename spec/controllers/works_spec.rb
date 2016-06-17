require 'rails_helper'

RSpec.describe WorksController, type: :controller do
  describe 'GET /index' do
    it 'should assign all works to @works' do
      # work = FactoryGirl.create(:work)
      get 'index'
      expect(assigns(:works)).to eq(Work.all)
    end
  end

  describe 'GET /new' do
    before(:each) do
      @user = create :user_valid
      sign_in @user
    end
    
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    before(:each) do
      @user = create :user_valid
      sign_in @user
    end
    
    it 'should create a new work' do
      work_params = FactoryGirl.attributes_for(:work)
      post :create, work: work_params
      expect(Work.exists?).to eq(true)
    end
  end
end
