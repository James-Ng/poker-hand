require 'spec_helper'
require 'poker_hand/card'

describe Card do
  describe '#initialize' do
    context 'Invalid card' do
      # prepare invalid card
      let(:nil_card) { Card.new(nil) }
      let(:empty_card) { Card.new('') }
      let(:invalid_length_card) { Card.new('nils') }
      let(:invalid_face_card) { Card.new('20s') }
      let(:invalid_suit_card) { Card.new('10p') }

      it { expect { empty_card }.to raise_error(/Invalid card/) }
      it { expect { nil_card }.to raise_error(/Invalid card/) }

      it { expect { invalid_length_card }.to raise_error(ArgumentError) }
      it { expect { invalid_face_card }.to raise_error(ArgumentError) }
      it { expect { invalid_suit_card }.to raise_error(/Invalid card/) }
    end

    context 'valid card' do
      let(:card1) { Card.new('AD') }
      let(:card2) { Card.new('2c') }
      let(:card3) { Card.new('10s') }
      let(:card4) { Card.new('kH') }

      it 'return face and suit' do
        expect(card1.face).to eq(14)
        expect(card1.suit).to eq(2)
        expect(card2.face).to eq(2)
        expect(card2.suit).to eq(1)
        expect(card3.face).to eq(10)
        expect(card3.suit).to eq(0)
        expect(card4.face).to eq(13)
        expect(card4.suit).to eq(3)
      end

      it { expect(card4.to_s).to eq('KH') }

      it 'check ace?' do
        expect(card1.ace?).to eq(true)
        expect(card2.ace?).to eq(false)
      end

      it 'low ace' do
        expect(card1.low_ace).to eq(1)
        expect(card2.low_ace).to eq(2)
      end
    end
  end
end
