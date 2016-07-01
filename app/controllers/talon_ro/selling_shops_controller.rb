class TalonRo::SellingShopsController < ApplicationController
  def index
  end

  def search
    # TODO: move the market offer gethering (and persisting)
    # away from the controller
    @results = market_agent.scrap(params[:item_name])
    # @results.each { |offer| Offer.create(MarketAdapters::TalonRo.new(offer)) }

    render :index
  end

  private

  def market_agent
    @@market_agent ||= MarketRogue::TalonRO.new(username: ENV['T_USERNAME'], password: ENV['T_PASSWORD'])
  end
end
