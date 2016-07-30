require 'rails_helper'

RSpec.describe AlertsController, type: :controller do
  let!(:alert) { create(:alert) }

  describe "GET #index" do
    it "assigns all alerts as @alerts" do
      get :index
      expect(assigns(:alerts)).to eq([alert])
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested alert" do
      expect {
        delete :destroy, params: { id: alert.to_param }
      }.to change(Alert, :count).by(-1)
    end

    it "redirects to the alerts list" do
      delete :destroy, params: { id: alert.to_param }
      expect(response).to redirect_to(alerts_url)
    end
  end
end
