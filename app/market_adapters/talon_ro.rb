# Offer model
# t.string :item_name
# t.string :cards
# t.integer :price
# t.integer :amount
# t.string :vendor
# t.string :shop_title
# t.string :map_location

module MarketAdapters
  class TalonRO
    def initialize offer
      {
        item_name:    offer.fetch(:item_name),
        refinement:   offer.fetch(:refinement, nil),
        slots:        offer.fetch(:slots, 0),
        cards:        offer.fetch(:cards, nil),
        price:        offer.fetch(:price),
        amount:       offer.fetch(:amount),
        shop_title:   offer.fetch(:shop_title),
        vendor:       offer.fetch(:vendor),
        map_location: offer.fetch(:coords, nil)
      }
    end
  end
end
