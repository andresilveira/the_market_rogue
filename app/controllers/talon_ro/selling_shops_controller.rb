class TalonRO::SellingShopsController < ApplicationController
  def search
    # TODO: move the market offer gethering (and persisting)
    # away from the controller
    results = market_agent.scrap(params[:item_name])

    @offers = results.group_by{|o| o[:item_name]}.flat_map do |item_name, offers| 
      item = Item.find_or_create_by(name: item_name)
      offers.map { |o| Offer.create(MarketAdapters::TalonRO.new(o).to_h.merge({ item_id: item.id })) }
    end

    render :search
  end

  private

  def market_agent
    @@market_agent ||= MarketRogue::TalonRO.new(username: ENV['T_USERNAME'], password: ENV['T_PASSWORD'])
  end
end
