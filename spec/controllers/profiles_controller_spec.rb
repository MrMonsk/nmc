require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  before(:each) do
    @user = create :user
    sign_in @user
  end

  describe 'GET /show' do
    before(:each) do
      @profile = create :profile_valid
      get :show, id: @profile.id
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns profile to @profile' do
      expect(assigns(:profile)).to eq(@profile)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  # describe 'POST /create' do
  #   context 'when profile is valid' do
  #     before(:each) do
  #       post :create, profile: FactoryGirl.attributes_for(:profile_valid)
  #     end
  #
  #     it 'creates new profile' do
  #       expect(Profile.count).to eq(1)
  #     end
  #
  #     it 'redirects to profile_path' do
  #       expect(response).to redirect_to(profile_path)
  #     end
  #
  #     it 'displays correct flash success message' do
  #       expect(flash[:notice]).to eq('Your profile has been added successfully!')
  #     end
  #   end
  #
  #   context 'when bio is empty' do
  #     before(:each) do
  #       post :create, profile: FactoryGirl.attributes_for(:profile_blank)
  #     end
  #
  #     it 'redirects to new_profile_path' do
  #       expect(response).to redirect_to(new_profile_path)
  #     end
  #
  #     it 'displays correct flash info message' do
  #       expect(flash[:alert]).to eq('Oops! It looks like you forgot to enter a bio.')
  #     end
  #   end
  #
  #   context 'when profile already exists' do
  #     before(:each) do
  #       2.times { post :create, profile: FactoryGirl.attributes_for(:profile_valid) }
  #     end
  #
  #     it 'redirects to new_profile_path' do
  #       expect(response).to redirect_to(new_profile_path)
  #     end
  #
  #     it 'displays correct flash info message' do
  #       expect(flash[:alert]).to eq('Oops! It looks like this profile already exists.')
  #     end
  #   end
  # end

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

    context 'when user is the owner and the profile does not exist' do
      before(:each) do
        get :edit, id: 'invalid'
      end

      it 'redirects to profile_path' do
        expect(response).to redirect_to(profile_path)
      end

      it 'displays correct flash info message' do
        expect(flash[:alert]).to eq('Oops! Profile not found.')
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
        expect(response).to redirect_to(profile_path(assigns[:profile]))
      end

      it 'displays correct flash info message' do
        expect(flash[:alert]).to eq('You are not the owner of this profile.')
      end
    end
  end

  describe 'PATCH /update' do
    before(:each) do
      @profile = create :profile_valid
      # @user.profile << @profile
    end

    context 'when update is valid' do
      before(:each) do
        patch :update, id: @profile, profile: FactoryGirl.attributes_for(:profile_valid, bio: 'New Bio')
        @profile.reload
      end

      it 'updates existing profile' do
        expect(Profile.find_by_id(@profile.id).bio).to eq('New Bio')
      end

      it 'redirects to profile_path' do
        expect(response).to redirect_to(profile_path(assigns[:profile]))
      end

      it 'displays correct flash success message' do
        expect(flash[:notice]).to eq('Your profile has been updated successfully!')
      end
    end

    context 'when update is invalid - blank bio' do
      before(:each) do
        patch :update, id: @profile, profile: FactoryGirl.attributes_for(:profile_valid, bio: '')
        @profile.reload
      end

      it 'does not update existing profile' do
        expect(Profile.find_by_id(@profile.id).bio).to eq('New Bio')
      end

      it 'redirects to edit_profile_path' do
        expect(response).to redirect_to(edit_profile_path(assigns[:profile]))
      end

      it 'displays correct flash info message' do
        expect(flash[:alert]).to eq('Oops! It looks like you forgot to enter a bio.')
      end
    end

    context 'when update is invalid - incorrect user' do
      before(:each) do
        sign_out @user
        user_2 = create :user
        sign_in user_2
        patch :update, id: @profile, profile: FactoryGirl.attributes_for(:profile_valid, bio: 'New Bio')
        @profile.reload
      end

      it 'does not update existing profile' do
        expect(Profile.find_by_id(@profile.id).bio).to eq('New Bio')
      end

      it 'redirects to profile_path' do
        expect(response).to redirect_to(profile_path(assigns[:profile]))
      end

      it 'displays correct flash info message' do
        expect(flash[:alert]).to eq('You are not the owner of this profile.')
      end
    end
  end
end
