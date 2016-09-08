require 'spec_helper'
require 'poker_hand/card'

describe 'Card' do
    let(:card1) { Card.new('AD') }
    let(:card2) { Card.new('2c') }
    let(:card3) { Card.new('10s') }
    let(:card4) { Card.new('kH') }
    let(:card5) { Card.new('kHa1') }
    let(:card6) { Card.new('20s') }

    context 'success init' do
        it { expect(card1.face).to eq(Card::FACE_VALUES['A']) }
        it { expect(card1.suit).to eq(Card::SUIT_VALUES['D']) }

        it { expect(card1.ace?).to eq(true) }
        it { expect(card2.ace?).to eq(false) }

        it { expect(card2.face).to eq(Card::FACE_VALUES['2']) }
        it { expect(card2.suit).to eq(Card::SUIT_VALUES['C']) }

        it { expect(card3.face).to eq(Card::FACE_VALUES['10']) }
        it { expect(card3.suit).to eq(Card::SUIT_VALUES['S']) }

        it { expect(card4.face).to eq(Card::FACE_VALUES['K']) }
        it { expect(card4.suit).to eq(Card::SUIT_VALUES['H']) }

        it { expect(card1.to_s).to eq("AD") }
    end

    context 'failed init' do
      it { expect { Card.new('AF') }.to raise_error(ArgumentError) }
      it { expect { Card.new('1D') }.to raise_error(ArgumentError) }
      it { expect { Card.new('') }.to raise_error(ArgumentError) }
      it { expect { card5 }.to raise_error(ArgumentError) }
      it { expect { card6 }.to raise_error(ArgumentError) }
    end
end
