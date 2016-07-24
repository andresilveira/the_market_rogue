require 'rails_helper'

RSpec.describe MarketAdapters::TalonRO do
  let(:adapter) {
    MarketAdapter::TalonRO.new({
      item_name: 'item name',
      refinement: 1,
      slots:      2,
      cards:      'turtle card',
      price:      1000,
      amount:     3,
      shop_title: 'Aloha shop',
      vendor:     'Aloha vendor',
      coords:     'Prontera(123,123)'
    })
  }

  describe 'when receiving an offer like hash' do
    [ :item_name,
      :refinement,
      :slots,:cards,
      :price,
      :amount,
      :shop_title,
      :vendor,
      :map_location
    ].each do |attribute|
      it "should contain the attribute #{attribute}" do
        expect(adapter.to_h).to include(attribute)
      end
    end
  end
end
