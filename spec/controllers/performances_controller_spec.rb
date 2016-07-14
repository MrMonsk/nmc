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

  describe 'GET /edit' do
    before(:each) do
      @performance = create :performance_valid
    end

    context 'when user is the owner and the performance exists' do
      before(:each) do
        get :edit, id: @performance.id
      end

      it 'returns http success' do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is the owner and the performance does not exist' do
      before(:each) do
        get :edit, id: 'invalid'
      end

      it 'redirects to performances_path' do
        expect(response).to redirect_to(performances_path)
      end

      it 'displays correct flash info message' do
        expect(flash[:alert]).to eq('Oops! Performance not found.')
      end
    end

    context 'when user is not the owner' do
      before(:each) do
        sign_out @user
        user_2 = create :user
        sign_in user_2
        get :edit, id: @performance.id
      end

      it 'redirects to performance_path' do
        expect(response).to redirect_to(performance_path(assigns[:performance]))
      end

      it 'displays correct flash info message' do
        expect(flash[:alert]).to eq('Oops! You cannot edit this performance since you are not the owner.')
      end
    end
  end

  describe 'PATCH /update' do
    before(:each) do
      @performance = create :performance_valid
      @user.performances << @performance
    end

    context 'when update is valid' do
      before(:each) do
        patch :update, id: @performance, performance: FactoryGirl.attributes_for(:performance_valid, title: 'New Title')
        @performance.reload
      end

      it 'updates existing performance' do
        expect(Performance.find_by_id(@performance.id).title).to eq('New Title')
      end

      it 'redirects to performance_path' do
        expect(response).to redirect_to(performance_path(assigns[:performance]))
      end

      it 'displays correct flash success message' do
        expect(flash[:notice]).to eq('Your performance has been updated successfully!')
      end
    end

    context 'when update is invalid - blank title' do
      before(:each) do
        patch :update, id: @performance, performance: FactoryGirl.attributes_for(:performance_valid, title: '')
        @performance.reload
      end

      it 'does not update existing performance' do
        expect(Performance.find_by_id(@performance.id).title).to eq('Test Title')
      end

      it 'redirects to edit_performance_path' do
        expect(response).to redirect_to(edit_performance_path(assigns[:performance]))
      end

      it 'displays correct flash info message' do
        expect(flash[:alert]).to eq('Oops! It looks like you forgot to enter a title.')
      end
    end

    context 'when update is invalid - incorrect user' do
      before(:each) do
        sign_out @user
        user_2 = create :user
        sign_in user_2
        patch :update, id: @performance, performance: FactoryGirl.attributes_for(:performance_valid, title: 'New Title')
        @performance.reload
      end

      it 'does not update existing performance' do
        expect(Performance.find_by_id(@performance.id).title).to eq('Test Title')
      end

      it 'redirects to performance_path' do
        expect(response).to redirect_to(performance_path(assigns[:performance]))
      end

      it 'displays correct flash info message' do
        expect(flash[:alert]).to eq('You are not the owner of this performance.')
      end
    end
  end

  describe 'DELETE /destroy' do
    before(:each) do
      @performance = create :performance_valid
      @user.performances << @performance
    end

    it 'should only allow owner of work to destroy' do
      p = FactoryGirl.create(:performance_other)
      delete :destroy, id: p.id
      expect(flash[:alert]).to eq('You are not the owner of this performance.')
      expect(response).to redirect_to performance_path(p)
    end

    it 'should allow a user to destroy a performance' do
      p = @performance
      delete :destroy, id: p.id
      expect(response).to redirect_to(performances_path)
      p = Performance.find_by_id(p.id)
      expect(p).to eq nil
    end

    it 'should return error if performance does not exist' do
      delete :destroy, id: 'uwotm8'
      expect(response).to redirect_to(performances_path)
    end
  end
end
