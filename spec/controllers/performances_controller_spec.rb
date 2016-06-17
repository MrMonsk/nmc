require 'rails_helper'

RSpec.describe PerformancesController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    before(:each) do
      @user = create :user_valid
      @performance = create :performance_valid
      sign_in @user
    end
      
    it 'returns http success' do
      get :show, id: @performance.id
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
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
    context 'when performance is valid' do
      
      before(:each) do
        @user = create :user_valid
        sign_in @user
        post :create, performance: FactoryGirl.attributes_for(:performance_valid)
      end

      it 'creates new performance' do
        expect(Performance.count).to eq(1)
      end

      it 'redirects to performances_path' do
        expect(response).to redirect_to(performances_path)
      end

      it 'displays correct flash success message' do
        expect(flash[:success]).to eq('Your performance has been added successfully!')
      end
    end

    context 'when title is empty' do
      before(:each) do
        @user = create :user_valid
        sign_in @user
        post :create, performance: FactoryGirl.attributes_for(:performance_blank)
      end

      it 'displays correct flash info message' do
        expect(flash[:info]).to eq('Oops! It looks like you forgot to enter a title.')
      end

      it 'redirects to new_performance_path' do
        expect(response).to redirect_to(new_performance_path)
      end
    end

    context 'when performance already exists' do
      before(:each) do
        @user = create :user_valid
        sign_in @user
        2.times { post :create, performance: FactoryGirl.attributes_for(:performance_valid) }
      end

      it 'displays correct flash info message' do
        expect(flash[:info]).to eq('Oops! It looks like this performance already exists.')
      end

      it 'redirects to new_performance_path' do
        expect(response).to redirect_to(new_performance_path)
      end
    end
  end
end
