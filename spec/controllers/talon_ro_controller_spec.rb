require 'rails_helper'

RSpec.describe TalonROController, type: :controller do
  describe 'GET #search' do
    before do 
      allow(OffersGrabber).to receive_message_chain(:new, offers: [])
      login_user
    end

    it "returns http success" do
      get :search
      expect(response).to have_http_status(:success)
    end
  end
end
