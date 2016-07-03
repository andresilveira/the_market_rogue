require 'rails_helper'

RSpec.describe Offer, type: :model do
  describe '#full_item_name' do
    it 'shows the slots when there are slots to show' do
      offer = Offer.new(slots: 1, item_name: 'name')
      expect(offer.full_item_name).to eq('name [1]')
    end

    it 'shows the refinement when there are refinement to show' do
      offer = Offer.new(refinement: 1, item_name: 'name')
      expect(offer.full_item_name).to eq('+1 name')
    end

    it 'shows the slots and refinement when there are slots and refinement o show' do
      offer = Offer.new(slots: 1, refinement: 1, item_name: 'name')
      expect(offer.full_item_name).to eq('+1 name [1]')
    end

    it 'omits slots and refinement if they are zero' do
      offer = Offer.new(slots: 0, item_name: 'name', refinement: 0)
      expect(offer.full_item_name).to eq('name')
    end
  end

  describe 'validations' do
    let(:offer) { create(:offer) }
    let(:duplicated_offer) { Offer.new(offer.attributes.merge({id: nil})) }

    it "prevents an offer from being saved if item_name, slots, refinement, cards, price, vendor, shop_title, map_location are the same" do
      expect(duplicated_offer).to be_invalid

      duplicated_offer.price = offer.price + 1000
      expect(duplicated_offer).to be_valid
    end
  end
end
