require 'rails_helper'

RSpec.describe BetaCandidatesController, type: :controller do
  describe 'POST /create' do
    context 'when email is valid' do
      before(:each) do
        post :create, beta_candidate: FactoryGirl.attributes_for(:beta_candidate)
      end

      it 'creates new beta candidate entry' do
        expect(BetaCandidate.count).to eq(1)
      end

      it 'redirects to root_path' do
        expect(response).to redirect_to(root_path)
      end

      it 'displays correct flash success message' do
        expect(flash[:success]).to eq('Thank you for signing up for the beta! You will be notified when the site goes live.')
      end
    end

    context 'when email is empty' do
      before(:each) { post :create, beta_candidate: { email: '' } }

      it 'displays correct flash info message' do
        expect(flash[:info]).to eq('Oops! It looks like you forgot to enter your email address.')
      end

      it 'redirects to root_path' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when email already exists' do
      before(:each) do
        2.times { post :create, beta_candidate: { email: 'test@gmail.com' } }
      end

      it 'displays correct flash info message' do
        expect(flash[:info]).to eq("It looks like you're already signed up for the beta!")
      end

      it 'redirects to root_path' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
