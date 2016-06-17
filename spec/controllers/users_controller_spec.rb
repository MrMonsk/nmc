require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET /show' do
    it 'should show the user profile page' do
      user = FactoryGirl.create(:user)
      sign_in user
      get :show, id: user.id
      expect(response).to have_http_status(:success)
    end
    
    it 'should return error if user not found' do
      user = FactoryGirl.create(:user)
      sign_in user
      get :show, id: 'uwotm8'
      expect(response).to have_http_status(:not_found)
    end
  end
end
