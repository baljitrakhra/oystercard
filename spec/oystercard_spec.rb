require_relative '../lib/oystercard'

describe Oystercard do
  let(:card) { Oystercard.new}

  describe '#balance' do
    it 'starts with a balance of 0.0' do
      expect(card.balance).to eq 0.0
    end
  end

  describe '#top_up' do
    it 'should add an amount to balance' do
      expect { card.top_up(30) }.to change { card.balance }.by(30.0)
    end

    it 'should limit the card to default limit' do
      expect { card.top_up(100) }.to raise_error "Cannot exceed #{Oystercard::DEFAULT_LIMIT} limit"
    end
  end

 

  describe '#touch_in' do
    let (:station) {double :station}

    it {is_expected.to respond_to(:touch_in).with(1).argument}

    it 'should change card state to in use' do
      card.top_up(50)
      expect { card.touch_in(station) }.to change{card.entry_station}.to station 
    end

    it 'should raise an error if balance is below minimum fare' do
      expect { card.touch_in(station) }.to raise_error "Below minimum fare"
    end

  end

  describe '#touch_out' do
    let (:station_entry) {double :station}
    let (:station_exit) {double :station}

    before do
      card.top_up(30)
      card.touch_in(station_entry)
    end

    it {is_expected.to respond_to(:touch_out).with(1).argument}

   

    it 'should deduct the minimum fare' do
      expect { card.touch_out(station_exit) }.to change { card.balance }.by(-Oystercard::MINIMUM_FARE)
    end

    it 'will tell you which station you have exited from' do
      expect { card.touch_out(station_exit) }.to change { card.exit_station}.to station_exit
    end
  end

  describe '#list_of_journeys' do
  let (:station_entry) {double :station}
  let (:station_exit) {double :station}
  let (:journey) {{entry_station: station_entry, exit_station: station_exit}}

    it 'gives an empty array by default' do
      expect(card.list_of_journeys).to eq []
    end

    it 'stores a journey' do
      card.top_up(30)
      card.touch_in(station_entry)
      card.touch_out(station_exit)
      expect(card.list_of_journeys).to include journey
      expect(card.list_of_journeys.length).to eq 1
    end
  end
end
