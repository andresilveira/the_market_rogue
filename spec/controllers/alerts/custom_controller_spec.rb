require 'rails_helper'

RSpec.describe Alerts::CustomController, type: :controller do
  let(:item) { create(:item) }
  let(:valid_attributes) {
    { item_id: item.id, price: 1000, operation: Alert::OPERATIONS[:greater_than_or_equal_to], offer_type: 'Type' }
  }

  let(:invalid_attributes) {
    { item_id: item.id, price: nil, operation: Alert::OPERATIONS[:greater_than_or_equal_to], offer_type: 'Type' }
  }

  let(:valid_session) { {} }

  describe "GET #new" do
    it "assigns a new alert as @alert" do
      get :new, params: {}, session: valid_session
      expect(assigns(:alert)).to be_a_new(CustomAlert)
    end
  end

  describe "GET #edit" do
    it "assigns the requested alert as @alert" do
      custom_alert = CustomAlert.create! valid_attributes
      get :edit, params: {id: custom_alert.to_param}, session: valid_session
      expect(assigns(:alert)).to eq(custom_alert)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new CustomAlert" do
        expect {
          post :create, params: {custom_alert: valid_attributes}, session: valid_session
        }.to change(CustomAlert, :count).by(1)
      end

      it "assigns a newly created alert as @alert" do
        post :create, params: {custom_alert: valid_attributes}, session: valid_session
        expect(assigns(:alert)).to be_a(CustomAlert)
        expect(assigns(:alert)).to be_persisted
      end

      it "redirects to the created alert" do
        post :create, params: {custom_alert: valid_attributes}, session: valid_session
        expect(response).to redirect_to(alerts_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved alert as @alert" do
        post :create, params: {custom_alert: invalid_attributes}, session: valid_session
        expect(assigns(:alert)).to be_a_new(CustomAlert)
      end

      it "re-renders the 'new' template" do
        post :create, params: {custom_alert: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { item_id: item.id, price: 999, operation: Alert::OPERATIONS[:greater_than_or_equal_to], offer_type: 'Type' }
      }

      it "updates the requested alert" do
        custom_alert = CustomAlert.create! valid_attributes
        put :update, params: {id: custom_alert.to_param, custom_alert: new_attributes}, session: valid_session
        custom_alert.reload
        expect(assigns(:alert)).to eq(custom_alert)
      end

      it "assigns the requested alert as @alert" do
        custom_alert = CustomAlert.create! valid_attributes
        put :update, params: {id: custom_alert.to_param, custom_alert: valid_attributes}, session: valid_session
        expect(assigns(:alert)).to eq(custom_alert)
      end

      it "redirects to the alert" do
        custom_alert = CustomAlert.create! valid_attributes
        put :update, params: {id: custom_alert.to_param, custom_alert: valid_attributes}, session: valid_session
        expect(response).to redirect_to(alerts_url)
      end
    end

    context "with invalid params" do
      it "assigns the alert as @alert" do
        custom_alert = CustomAlert.create! valid_attributes
        put :update, params: {id: custom_alert.to_param, custom_alert: invalid_attributes}, session: valid_session
        expect(assigns(:alert)).to eq(custom_alert)
      end

      it "re-renders the 'edit' template" do
        custom_alert = CustomAlert.create! valid_attributes
        put :update, params: {id: custom_alert.to_param, custom_alert: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

end
