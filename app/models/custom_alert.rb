class CustomAlert < Alert
  validates_presence_of :price, :item_id, :operation, :offer_type

  def should_fire_for_offer? offer
    offer.item_id == item_id and
      offer.type == offer_type and
      offer.price.send(operation, price)
  end
end
