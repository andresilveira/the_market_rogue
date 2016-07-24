require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'tracked scope' do
    it 'returns all items with track_buyers or track_sellers set as true' do
      Item.create(name: 'untracked_item', track_buyers: false, track_sellers: false)

      tracking_seller = Item.create(name: 'tracking_seller', track_sellers: true)
      tracking_buyer = Item.create(name: 'tracking_buyer', track_buyers: true)

      expect(Item.tracked.to_a).to contain_exactly(tracking_buyer, tracking_seller)
    end
  end
end
