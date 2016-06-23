require 'rails_helper'

RSpec.describe PerformancesController, type: :controller do
  before(:each) do
    @user = create :user
    sign_in @user
  end

  describe 'GET /index' do
    before(:each) do
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns all performances to @performances' do
      expect(assigns(:performances)).to eq(Performance.all)
    end
  end

  describe 'GET /show' do
    before(:each) do
      @performance = create :performance_valid
      get :show, id: @performance.id
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns performance to @performance' do
      expect(assigns(:performance)).to eq(@performance)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'when performance is valid' do
      before(:each) do
        post :create, performance: FactoryGirl.attributes_for(:performance_valid)
      end

      it 'creates new performance' do
        expect(Performance.count).to eq(1)
      end

      it 'redirects to performances_path' do
        expect(response).to redirect_to(performances_path)
      end

      it 'displays correct flash success message' do
        expect(flash[:notice]).to eq('Your performance has been added successfully!')
      end
    end

    context 'when title is empty' do
      before(:each) do
        post :create, performance: FactoryGirl.attributes_for(:performance_blank)
      end

      it 'redirects to new_performance_path' do
        expect(response).to redirect_to(new_performance_path)
      end

      it 'displays correct flash info message' do
        expect(flash[:alert]).to eq('Oops! It looks like you forgot to enter a title.')
      end
    end

    context 'when performance already exists' do
      before(:each) do
        2.times { post :create, performance: FactoryGirl.attributes_for(:performance_valid) }
      end

      it 'redirects to new_performance_path' do
        expect(response).to redirect_to(new_performance_path)
      end

      it 'displays correct flash info message' do
        expect(flash[:alert]).to eq('Oops! It looks like this performance already exists.')
      end
    end
  end
end
