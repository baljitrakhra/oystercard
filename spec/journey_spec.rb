require_relative '../lib/journey'
require_relative '../lib/oystercard'
describe Journey do 
  let(:double_entry_station) {double :station}
  let(:double_exit_station) {double :station}
  let(:card) {Oystercard.new}

  describe '#journey creation' do
    it ' has a entry station at start' do
    subject = Journey.new(double_entry_station)
    expect(subject.entry_station).to eq double_entry_station 
    end
  end
  describe '#completing itself' do
    it ' except an exit station' do
      subject.end_journey(double_exit_station)
      expect(subject.exit_station).to eq double_exit_station 
    end
  end
  describe '#completeness checks' do
      
    let(:subject) {Journey.new(double_entry_station)}
      
    it 'when there is an entery station and an exit station' do
      subject.end_journey(double_exit_station)
      expect(subject.entry_station).to eq nil
    end
    it {is_expected.to respond_to(:complete?)}
    
    it ': if card is touched out twice' do
      card.top_up(10)
      card.touch_in(double_entry_station)
      card.touch_in(double_entry_station)
      expect(subject.complete?).to eq false
    end
  end
  
  describe '#fare' do
    #let(:subject) {Journey.new(double_entry_station)}
    it 'calcualte fare for journey' do
      card.top_up(10)
      card.touch_in(double_entry_station)
      card.touch_out(double_exit_station)
      #  subject.end_journey(double_exit_station)
      expect(subject.fare).to eq Oystercard::MINIMUM_FARE
    end
  end

end
