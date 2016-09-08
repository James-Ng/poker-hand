require 'spec_helper'
require 'poker_hand/hand'
require 'poker_hand/card'

describe Hand do
  describe '#initialize' do
    context 'Valid hand' do
      let(:valid_hand) { Hand.new('2h 3h 4h 5h 6h') }
      let(:valid_hand2) { Hand.new('2H 10d 4h Ks aC') }

      it { expect(valid_hand.cards.size).to eq 5 }
      it { expect(valid_hand2.cards.size).to eq 5 }
    end

    context 'invalid hand' do
      let(:err_cards) { Hand.new('AF KD JH QD 9H') }
      let(:duplicate_cards) { Hand.new('AC AC 7H 5D 5H') }
      let(:miss_cards) { Hand.new('AF KD JH QD') }

      it { expect { duplicate_cards }.to raise_error(/duplicate cards/) }
      it { expect { err_cards }.to raise_error(/Invalid card/) }
      it { expect { miss_cards }.to raise_error(ArgumentError) }
    end
  end

  describe '#straight_flush?' do
    let(:not_straight_flush_hand) { Hand.new('5c 7C 8C 6c ad') }
    let(:high_ace_straight_flush_hand) { Hand.new('qc KC jC 10c AC') }
    let(:low_ace_straight_flush_hand) { Hand.new('5c 4C 3C 2c aC') }

    it { expect(not_straight_flush_hand.straight_flush?).to eq false }
    it { expect(high_ace_straight_flush_hand.straight_flush?).to eq true }
    it { expect(low_ace_straight_flush_hand.straight_flush?).to eq true }
  end

  describe '#flush?' do
    let(:not_flush_hand) { Hand.new('5c 7C 8C 10c ad') }
    let(:flush_hand) { Hand.new('5c 7C 8C 10c aC') }

    it { expect(flush_hand.flush?).to eq true }
    it { expect(not_flush_hand.flush?).to eq false }
  end

  describe '#straight?' do
    let(:not_straight_hand) { Hand.new('5c 7C 8C 6c ad') }
    let(:high_ace_straight_hand) { Hand.new('qc KD jC 10c AC') }
    let(:low_ace_straight_hand) { Hand.new('5c 4S 3C 2H aC') }

    it { expect(not_straight_hand.straight?).to eq false }
    it { expect(high_ace_straight_hand.straight?).to eq true }
    it { expect(low_ace_straight_hand.straight?).to eq true }
  end

  describe '#four_of_a_kind?' do
    let(:not_four_hand) { Hand.new('5c 7C 8C 10c ad') }
    let(:four_hand) { Hand.new('5c 5D 5H 5s aC') }

    it { expect(not_four_hand.four_of_a_kind?).to eq false }
    it { expect(four_hand.four_of_a_kind?).to eq true }
  end

  describe '#three_of_a_kind?' do
    let(:not_three_hand) { Hand.new('5c 7C 8C 10c ad') }
    let(:three_hand) { Hand.new('5c 5D 5H 2s aC') }

    it { expect(not_three_hand.three_of_a_kind?).to eq false }
    it { expect(three_hand.three_of_a_kind?).to eq true }
  end

  describe '#two_pair?' do
    let(:not_two_pair_hand) { Hand.new('5c 7C 8C 10c ad') }
    let(:two_pair_hand) { Hand.new('5c 5D 2H 2s aC') }

    it { expect(not_two_pair_hand.two_pair?).to eq false }
    it { expect(two_pair_hand.two_pair?).to eq true }
  end

  describe '#one_pair?' do
    let(:not_one_pair_hand) { Hand.new('5c 7C 8C 10c ad') }
    let(:one_pair_hand) { Hand.new('5c 5D 3H 2s aC') }

    it { expect(not_one_pair_hand.one_pair?).to eq false }
    it { expect(one_pair_hand.one_pair?).to eq true }
  end

  describe '#highest_card' do
    let(:high_card_hand) { Hand.new('5c 5D 3H 2s aC') }

    it { expect(high_card_hand.highest_card).to include 'AC' }
  end

  describe '#rankings' do
    let(:straight_flush_high_card_hand) { Hand.new('KD AD QD JD 10D') }
    let(:flush_high_card_hand) { Hand.new('KD AD 7D 5D 4D') }
    let(:straight_high_card_hand) { Hand.new('10D 9D 7s 8D 6D') }
    let(:four_high_card_hand) { Hand.new('KD Ks Kh kc as') }
    let(:three_one_pair_high_card_hand) { Hand.new('KD Ks Kh 10s 10D') }
    let(:two_pair_high_card_hand) { Hand.new('AC AD 7H 5D 5H') }
    let(:one_pair_high_hand) { Hand.new('AC AD 7H 3D 5H') }
    let(:only_high_card_hand) { Hand.new('AC 4D 7H 5D 6C') }

    it { expect(straight_flush_high_card_hand.rankings).to eq(['Straight flush', 'Flush', 'Straight', 'high card: AD']) }
    it { expect(flush_high_card_hand.rankings).to eq(['Flush', 'high card: AD']) }
    it { expect(straight_high_card_hand.rankings).to eq(['Straight', 'high card: 10D']) }
    it { expect(four_high_card_hand.rankings).to eq(['Four of a kind', 'high card: AS']) }
    it { expect(three_one_pair_high_card_hand.rankings).to eq(['Three of a kind', 'One pair', 'high card: KH']) }
    it { expect(two_pair_high_card_hand.rankings).to eq(['Two pair', 'high card: AD']) }
    it { expect(one_pair_high_hand.rankings).to eq(['One pair', 'high card: AD']) }
    it { expect(only_high_card_hand.rankings).to eq(['high card: AC']) }
  end
end
