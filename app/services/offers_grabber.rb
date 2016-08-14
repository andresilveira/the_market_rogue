# TODO: dry out the Item creation and Notify responsibility
class OffersGrabber
  OFFER_TYPES = [:BuyingOffer, :SellingOffer]

  def initialize(item_name, offer_type, notifier = ::NullNotifier.new)
    @offer_type = check_offer_type(offer_type.to_sym)
    @item_name = item_name
    @notifier = notifier
  end

  def offers
    @offers ||= create_offers_and_items_if_non_existent
  end

  private

  def results
    case @offer_type
    when :BuyingOffer
      @results ||= market_agent.buying_item(@item_name)
    when :SellingOffer
      @results ||= market_agent.selling_item(@item_name)
    else
      @results ||= []
    end
  end

  def check_offer_type type
    unless OFFER_TYPES.include?(type)
      fail ArgumentError.new(
        "Offer type: #{type} is unknown. Try one of #{OFFER_TYPES}"
      )
    end
    type
  end

  def create_offers_and_items_if_non_existent
    results_grouped_by_item.flat_map do |item_name, offers| 
      item = Item.find_or_create_by(name: item_name)
      offers.map { |offer| create_offer_for_item_and_notify item.id, offer }
    end
  end

  def results_grouped_by_item 
    results.group_by{ |offer| offer[:item_name] }
  end

  def create_offer_for_item_and_notify item_id, offer_attributes
    adapted_offer_attributes = MarketAdapters::TalonRO.new(offer_attributes).to_h
    adapted_offer_attributes[:item_id] = item_id
    adapted_offer_attributes[:type] = @offer_type
    if offer = Offer.create(adapted_offer_attributes)
      @notifier.notify(offer)
    end
    offer
  end

  def market_agent
    @market_agent ||= MarketRogue::TalonRO.new(username: ENV['T_USERNAME'], password: ENV['T_PASSWORD'])
  end
end
