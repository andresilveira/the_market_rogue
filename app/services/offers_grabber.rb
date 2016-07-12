class OffersGrabber

  attr_reader :offers

  def initialize(item_name)
    @results = market_agent.scrap(item_name)
    @offers = create_offers_and_items_if_non_existent
  end

  private

  def create_offers_and_items_if_non_existent
    results_grouped_by_item.flat_map do |item_name, offers| 
      item = Item.find_or_create_by(name: item_name)
      offers.map { |offer| create_offer_for_item item.id, offer }
    end
  end

  def results_grouped_by_item 
    @results.group_by{ |offer| offer[:item_name] }
  end

  def create_offer_for_item item_id, offer_attributes
    adapted_offer_attributes = MarketAdapters::TalonRO.new(offer_attributes).to_h
    adapted_offer_attributes[:item_id] = item_id
    Offer.create(adapted_offer_attributes)
  end

  def market_agent
    @market_agent ||= MarketRogue::TalonRO.new(username: ENV['T_USERNAME'], password: ENV['T_PASSWORD'])
  end
end
