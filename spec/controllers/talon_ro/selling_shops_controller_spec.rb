require 'rails_helper'

RSpec.describe TalonRO::SellingShopsController, type: :controller do
  describe 'GET #search' do
    it "returns http success" do
      allow(OffersGrabber).to receive_message_chain(:new, offers: [])

      get :search
      expect(response).to have_http_status(:success)
    end
  end
end
