require 'spec_helper'
require 'poker_hand/hand'
require 'poker_hand/card'

describe 'Hand' do
  let(:hand1) { Hand.new("2h 3h 4h 5h 6h") }
  let(:hand2) { Hand.new("2h 2s 2d 2c 6h") }
  let(:hand3) { Hand.new("2h 2s 2d 3c 6h") }
  let(:hand4) { Hand.new("2h 2s 5d 5c 6h") }
  let(:hand5) { Hand.new("2h 2s 4d 5c 6h") }
  let(:hand6) { Hand.new("AC 4D 7H 5D 6C") }

  let(:hand7) { Hand.new("AC AD 7H 5D 5H") }
  let(:hand8) { Hand.new("AC 2D 4D 5H 3H") }
  let(:hand9) { Hand.new("AC KD QD 10H JH ") }
  let(:hand10) { Hand.new("AC KD JH QD 9H") }

  let(:err_cards) { Hand.new("AF KD JH QD 9H") }
  let(:one_pair) { Hand.new("Ah aD ks qc 2s")}
  let(:duplicate_cards) { Hand.new("AC AC 7H 5D 5H") }

  it { expect {err_cards}.to raise_error(/Invalid card/) }
  it { expect(one_pair.rankings).to eq(["One pair", "high card: AH"])}
  it 'Hand#straight()' do
    test = hand8.straight?
    expect(test).to eq(true)

  end
  it 'Hand#straight()' do
    test = hand9.straight?
    expect(test).to eq(true)

  end
  it 'Hand#straight()' do
    test = hand10.straight?
    expect(test).to eq(false)
  end

  it { expect { duplicate_cards }.to raise_error(/duplicate cards/) }

  it 'Hand#rankings()' do
    test = hand7.rankings
    expect(test).to eq(["Two pair", "high card: AD"])

  end

  it 'Hand#straight_flush()' do
    test = hand1.straight_flush?
    expect(test).to eq(true)

  end

  it 'Hand#get_highest_card()' do
    test = hand7.get_highest_card

    expect(test).to eq("high card: AD")

  end

  it 'Hand#rankings()' do
    test = hand1.rankings
    expect(test).to eq(["Straight flush", "Flush", "Straight", "high card: 6H"])
  end

  it 'Hand#four_of_a_kind()' do
    test = hand2.four_of_a_kind?
    expect(test).to eq(true)

  end
  it 'Hand#three_of_a_kind()' do
    test = hand3.three_of_a_kind?
    expect(test).to eq(true)

  end
  it 'Hand#flush()' do
    test = hand1.flush?
    expect(test).to eq(true)

  end

  it 'Hand#two_pair()' do
    test = hand4.two_pair?
    expect(test).to eq(true)

  end

  it 'Hand#one_pair()' do
    test = hand5.one_pair?
    expect(test).to eq(true)

  end
  it 'Hand#straight()' do
    test = hand1.straight?
    expect(test).to eq(true)

  end
end
