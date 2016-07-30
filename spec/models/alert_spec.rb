require 'rails_helper'

RSpec.describe Alert, type: :model do
  pending
end

RSpec.describe CustomAlert, type: :model do
  describe '#reached?' do
    let(:alert) { CustomAlert.new(
      price: 100,
      item_id: 1,
      offer_type: 'Type',
      operation: CustomAlert::OPERATIONS[:greater_than_or_equal_to]
    )}

    context 'when an offer matches the criteria' do
      let(:offer) { double(price: 100, item_id: 1, type: 'Type') }

      it 'should return true' do
        expect(alert.should_fire_for_offer?(offer)).to be_truthy
      end
    end

    context 'when an offer doesn\'t match the criteria' do
      let(:offer) { double(price: 99, item_id: 1, type: 'Type') }

      it 'returns false' do
        expect(alert.should_fire_for_offer?(offer)).to be_falsey
      end
    end
  end
end
