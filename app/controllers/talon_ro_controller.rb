class TalonROController < ApplicationController
  def search
    notifier = EmailNotifier.new
    @offers = OffersGrabber.new(params[:item_name], params[:offers_type], notifier).offers
  end
end
