class TalonRO::SellingShopsController < ApplicationController
  def index
    @offers = Offer.all
  end

  def search
    # TODO: move the market offer gethering (and persisting)
    # away from the controller
    results = market_agent.scrap(params[:item_name])
    @offers = results.map { |o| Offer.create(MarketAdapters::TalonRO.new(o).to_h) }

    render :index
  end

  private

  def market_agent
    @@market_agent ||= MarketRogue::TalonRO.new(username: ENV['T_USERNAME'], password: ENV['T_PASSWORD'])
  end
end
