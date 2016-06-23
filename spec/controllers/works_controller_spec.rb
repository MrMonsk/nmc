require 'rails_helper'

RSpec.describe WorksController, type: :controller do
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
    
    it 'assigns all works to @works' do
      expect(assigns(:works)).to eq(Work.all)
    end
  end
  
  describe 'GET /show' do
    before(:each) do
      @work = create :work_valid
      get :show, id: @work.id
    end
    
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    
    it 'assigns work to @work' do
      expect(assigns(:work)).to eq(@work)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'when work is valid' do
      before(:each) do
        post :create, work: FactoryGirl.attributes_for(:work_valid)
      end
      
      it 'creates new work' do
        expect(Work.count).to eq(1)
      end
      
      it 'redirects to works_path' do
        expect(response).to redirect_to(works_path)
      end
      
      it 'displays correct flash success message' do
        expect(flash[:notice]).to eq('Your work has been added successfully!')
      end
    end
    
    context 'when title is empty' do
      before(:each) do
        post :create, work: FactoryGirl.attributes_for(:work_blank)
      end

      it 'redirects to new_work_path' do
        expect(response).to redirect_to(new_work_path)
      end
      
      it 'displays correct flash info message' do
        expect(flash[:alert]).to eq('Oops! It looks like you forgot to enter a title.')
      end
    end
    
    context 'when work already exists' do
      before(:each) do
        2.times { post :create, work: FactoryGirl.attributes_for(:work_valid) }
      end

      it 'redirects to new_work_path' do
        expect(response).to redirect_to(new_work_path)
      end
      
      it 'displays correct flash info message' do
        expect(flash[:alert]).to eq('Oops! It looks like this work already exists.')
      end
    end
  end

  describe 'GET /edit' do
    before(:each) do
      @work = create :work_valid
    end
    
    context 'when user is the owner and the work exists' do
      before (:each) do
        get :edit, id: @work.id
      end
      
      it 'returns http success' do
        get :new
        expect(response).to have_http_status(:success)
      end
    end
    
    context 'when user is the owner and the work does not exist' do
      before (:each) do
        get :edit, id: 'invalid'
      end
      
      it 'redirects to works_path' do
        expect(response).to redirect_to(works_path)
      end
      
      it 'displays correct flash info message' do
        expect(flash[:alert]).to eq('Oops! Work not found.')
      end
    end
    
    context 'when user is not the owner' do
      before (:each) do
        sign_out @user
        user_2 = create :user
        sign_in user_2
        get :edit, id: @work.id
      end
      
      it 'redirects to work_path' do
        expect(response).to redirect_to(work_path(assigns[:work]))
      end
      
      it 'displays correct flash info message' do
        expect(flash[:alert]).to eq('Oops! You cannot edit this work since you are not the owner.')
      end
    end
  end

  describe 'PATCH /update' do
    before(:each) do
      @work = create :work_valid
      @user.works << @work
    end
    
    context 'when update is valid' do
      before(:each) do
        patch :update, id: @work, work: FactoryGirl.attributes_for(:work_valid, title: 'New Title')
        @work.reload
      end
      
      it 'updates existing work' do
        expect(Work.find_by_id(@work.id).title).to eq('New Title')
      end
      
      it 'redirects to work_path' do
        expect(response).to redirect_to(work_path(assigns[:work]))
      end
      
      it 'displays correct flash success message' do
        expect(flash[:notice]).to eq('Your work has been updated successfully!')
      end
    end
    
    context 'when update is invalid - blank title' do
      before(:each) do
        patch :update, id: @work.id, work: FactoryGirl.attributes_for(:work_valid, title: '')
        @work.reload
      end
      
      it 'does not update existing work' do
        expect(Work.find_by_id(@work.id).title).to eq('Op. 1')
      end
      
      it 'redirects to edit_work_path' do
        expect(response).to redirect_to(edit_work_path(assigns[:work]))
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
        patch :update, id: @work.id, work: FactoryGirl.attributes_for(:work_valid, title: 'New Title')
        @work.reload
      end
      
      it 'does not update existing work' do
        expect(Work.find_by_id(@work.id).title).to eq('Op. 1')
      end
      
      it 'redirects to work_path' do
        expect(response).to redirect_to(work_path(assigns[:work]))
      end
      
      it 'displays correct flash info message' do
        expect(flash[:alert]).to eq('Oops! You cannot edit this work since you are not the owner.')
      end
    end
  end
end
