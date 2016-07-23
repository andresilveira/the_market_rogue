class TalonROController < ApplicationController
  def search
    @offers = OffersGrabber.new(params[:item_name], params[:offers_type]).offers
  end
end
