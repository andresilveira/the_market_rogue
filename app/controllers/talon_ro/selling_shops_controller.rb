class TalonRO::SellingShopsController < ApplicationController
  def search
    @offers = OffersGrabber.new(params[:item_name]).offers
  end
end
