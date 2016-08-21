require "rails_helper"

RSpec.describe Alerts::CustomController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(:get => "/alerts/custom/new").to route_to("alerts/custom#new")
    end

    it "routes to #edit" do
      expect(:get => "/alerts/custom/1/edit").to route_to("alerts/custom#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/alerts/custom").to route_to("alerts/custom#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/alerts/custom/1").to route_to("alerts/custom#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/alerts/custom/1").to route_to("alerts/custom#update", :id => "1")
    end
  end
end
