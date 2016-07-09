require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      item = create(:item)
      get :show, params: { id: item.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    it "redirects the user to items#index if the record is found" do
      item = create(:item)
      delete :destroy, params: { id: item.id }
      expect(response).to redirect_to(action: :index)
    end
  end
end
