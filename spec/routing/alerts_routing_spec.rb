require "rails_helper"

RSpec.describe AlertsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/alerts").to route_to("alerts#index")
    end

    it "routes to #destroy" do
      expect(:delete => "/alerts/1").to route_to("alerts#destroy", :id => "1")
    end
  end
end
