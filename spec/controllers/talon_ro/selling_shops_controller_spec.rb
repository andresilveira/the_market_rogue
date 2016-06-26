require 'rails_helper'

RSpec.describe TalonRo::SellingShopsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #search' do
    before do
      @market_agent_double = double(scrap: [])
      allow(@controller).to receive(:market_agent) { @market_agent_double }
    end

    it "returns http success" do
      post :search
      expect(response).to have_http_status(:success)
    end

    it "assigns an array to @results" do
      post :search
      expect(assigns(:results)).to eq([])
    end
  end
end
