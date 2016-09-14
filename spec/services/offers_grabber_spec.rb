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
    allow(MarketRogue::TalonRO).to receive_message_chain(:new, selling_item: result)
    allow(MarketRogue::TalonRO).to receive_message_chain(:new, buying_item: result)
  end

  describe 'offer types' do
    it 'should be known' do
      expect { OffersGrabber.new('item_name', :some_type) }.to raise_error(ArgumentError, /Offer type/)
    end
  end

  describe 'when initialized with an empty name or item not foud' do
    before { stub_market_rogue }

    describe '#offers' do
      it 'returns empty array' do
        offers = OffersGrabber.new(nil, :SellingOffer).offers
        expect(offers).to be_empty
      end
    end
  end

  OffersGrabber::OFFER_TYPES.each do |type|
    describe "for #{type} offers" do
      describe 'when there are results' do
        before { stub_market_rogue [existing_item_offer] }
        let(:notifier) { spy(:notifier, notify: true) }
        let(:grabber) { OffersGrabber.new(existing_item.name, type, notifier) }
        subject { grabber }

        describe 'for a non existent item' do
          before { stub_market_rogue [offer_non_existing_item] }
          let!(:grabber) { OffersGrabber.new(new_item.name, type) }

          it 'creates the item' do
            subject.offers
            expect(Item.find_by(name: new_item.name)).to_not be_nil
          end
        end

        it 'creates the offers' do
          subject.offers
          expect(Offer.where(offer_fields.merge(type: type))).to_not be_empty
        end

        it 'attributes the offers to the item' do
          subject.offers
          offer = Offer.where(offer_fields.merge(type: type)).first
          expect(offer.item.id).to eq(existing_item.id)
        end

        it '#offers should contain the offer with the existing item' do
          expect(subject.offers).to eq(Offer.all.to_a)
        end

        it 'asks the notifier to notify' do
          subject.offers.each  do |offer|
            expect(notifier).to have_received(:notify).with(offer.id)
          end
        end
      end
    end
  end
end
