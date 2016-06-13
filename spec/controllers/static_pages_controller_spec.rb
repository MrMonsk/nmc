require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "static_pages#home" do
    it "should show the splash page" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end
end