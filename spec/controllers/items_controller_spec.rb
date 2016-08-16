require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let!(:item) { create(:item) }

  before { login_user }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: item.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    it "redirects the user to items#index if the record is found" do
      delete :destroy, params: { id: item.id }
      expect(response).to redirect_to(action: :index)
    end

    it "deletes the chosen item" do
      delete :destroy, params: { id: item.id }
      expect(Item.where(id: item.id)).to be_empty
    end
  end

  describe "PATCH #update" do
    describe "with valid params" do
      subject! { patch :update, params: { id: item.id, item: { track_sellers: true } } }

      it "responds with ok" do
        expect(response).to have_http_status(:success)
      end

      it "should update the attributes from item" do
        expect(item.reload.track_sellers).to be_truthy
      end
    end

    describe "with invalid params" do
      let!(:item) { create(:item, name: 'nice name') }
      subject! { patch :update, params: { id: item.id, item: { name: 'other nice name' } } }

      it "responds with no content" do
        expect(response).to have_http_status(:no_content)
      end

      it "should not update the attributes from item" do
        expect(item.reload.name).to eq('nice name')
      end
    end
  end
end
