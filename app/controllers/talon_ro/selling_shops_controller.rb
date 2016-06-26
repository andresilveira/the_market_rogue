class TalonRo::SellingShopsController < ApplicationController
  def index
  end

  def search
    @results = market_agent.scrap(params[:item_name])
    render :index
  end

  private

  def market_agent
    @@market_agent ||= MarketRogue::TalonRO.new(username: ENV['T_USERNAME'], password: ENV['T_PASSWORD'])
  end
end
