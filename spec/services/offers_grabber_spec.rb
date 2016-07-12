require 'rails_helper'

RSpec.describe OffersGrabber do
  let(:offer_fields) do {
    price:      1000,
    amount:     3,
    shop_title: 'Aloha shop',
    vendor:     'Aloha vendor'
  } end
  let(:existing_item) { create(:item) }
  let(:existing_item_offer) { { item_name:  existing_item.name }.merge(offer_fields) }
  let(:new_item) { build(:item) }
  let(:offer_non_existing_item){ { item_name:  new_item.name }.merge(offer_fields) } 

  def stub_market_rogue result = []
    allow(MarketRogue::TalonRO).to receive_message_chain(:new, scrap: result)
  end


  describe 'when initialized with an empty name or item not foud' do
    before { stub_market_rogue }

    describe '#offers' do
      it 'returns empty array' do
        offers = OffersGrabber.new(nil).offers
        expect(offers).to be_empty
      end
    end
  end

  describe 'when there are offers' do
    before do
      stub_market_rogue [existing_item_offer]
      OffersGrabber.new(existing_item.name)
    end

    describe 'for a non existent item' do
      before do
        stub_market_rogue [offer_non_existing_item]
        OffersGrabber.new(new_item.name)
      end

      it 'creates the item' do
        expect(Item.find_by(name: new_item.name)).to_not be_nil
      end
    end

    it 'creates the offers' do
      expect(Offer.where(offer_fields)).to_not be_empty
    end

    it 'attributes the offers to the item' do
      offer = Offer.where(offer_fields).first
      expect(offer.item.id).to eq(existing_item.id)
    end
  end
end
