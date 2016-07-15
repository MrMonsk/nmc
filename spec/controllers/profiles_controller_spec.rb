require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe 'GET /edit' do
    before(:each) do
      @profile = create :profile_valid
    end

    context 'when user is the owner and the profile exists' do
      before(:each) do
        get :edit, id: @profile.id
      end

      it 'returns http success' do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not the owner' do
      before(:each) do
        sign_out @user
        user_2 = create :user
        sign_in user_2
        get :edit, id: @profile.id
      end

      it 'redirects to profile_path' do
        expect(response).to redirect_to(profile_path(assigns[:profiles]))
      end

      it 'displays correct flash info message' do
        expect(flash[:alert]).to eq('Oops! You cannot edit this profile since you are not the owner.')
      end
    end
  end

  describe 'PATCH /update' do
    before(:each) do
      @profile = create :profile_valid
      @user.profile << @profile
    end

    context 'when update is valid' do
      before(:each) do
        patch :update, id: @profile, profile: FactoryGirl.attributes_for(:profile_valid, title: 'New Title')
        @profile.reload
      end

      it 'updates existing profile' do
        expect(Work.find_by_id(@profile.id).title).to eq('New Title')
      end

      it 'redirects to profile_path' do
        expect(response).to redirect_to(profile_path(assigns[:profile]))
      end

      it 'displays correct flash success message' do
        expect(flash[:notice]).to eq('Your profile has been updated successfully!')
      end
    end

    context 'when update is invalid - blank title' do
      before(:each) do
        patch :update, id: @profile, profile: FactoryGirl.attributes_for(:profile_valid, title: '')
        @profile.reload
      end

      it 'does not update existing profile' do
        expect(Work.find_by_id(@profile.id).title).to eq('Op. 1')
      end

      it 'redirects to edit_profile_path' do
        expect(response).to redirect_to(edit_profile_path(assigns[:profile]))
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
        patch :update, id: @profile, profile: FactoryGirl.attributes_for(:profile_valid, title: 'New Title')
        @profile.reload
      end

      it 'does not update existing profile' do
        expect(Work.find_by_id(@profile.id).title).to eq('Op. 1')
      end

      it 'redirects to profile_path' do
        expect(response).to redirect_to(profile_path(assigns[:profile]))
      end

      it 'displays correct flash info message' do
        expect(flash[:alert]).to eq('Oops! You cannot edit this profile since you are not the owner.')
      end
    end

    context 'when update is invalid - incorrect user' do
      before(:each) do
        sign_out @user
        user_2 = create :user
        sign_in user_2
        patch :update, id: @profile, profile: FactoryGirl.attributes_for(:profile_valid, title: 'New Title')
        @profile.reload
      end

      it 'does not update existing profile' do
        expect(Work.find_by_id(@profile.id).title).to eq('Op. 1')
      end

      it 'redirects to profile_path' do
        expect(response).to redirect_to(profile_path(assigns[:profile]))
      end

      it 'displays correct flash info message' do
        expect(flash[:alert]).to eq('Oops! You cannot edit this profile since you are not the owner.')
      end
    end
  end
end
