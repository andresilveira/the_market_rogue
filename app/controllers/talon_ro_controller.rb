class TalonROController < ApplicationController
  before_action :authenticate_user!

  def search
    @offers = OffersGrabber.new(params[:item_name], params[:offers_type]).offers
  end
end
