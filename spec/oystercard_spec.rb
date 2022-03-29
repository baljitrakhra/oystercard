require_relative '../lib/oystercard.rb'
describe Oystercard do
  
  let(:card) {Oystercard.new}
  
  describe '#balance' do

    it 'is checkes for that new cards have zero balance' do
      expect(card.balance).to eq 0
    end
  end 

  describe '#topup' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'let you add money to your card' do
    expect{ card.top_up 20 }.to change{ card.balance }.by 20
    end

    it 'raise an error if due to top_up balance on card goes over £90' do
    card.top_up Oystercard::MAXIMUM_VALUE
    expect {card.top_up 1 }.to raise_error "Balance of card is limited to #{Oystercard::MAXIMUM_VALUE}"
    end
  end


  describe '#touch_in' do
    let(:station) {double :station}

    it {is_expected.to respond_to(:touch_in)}

    it 'let the passenger to start the journey' do
       card.top_up(10)
       card.touch_in(station)
       expect(card.in_journey?).to eq true
    end 
    
    it 'raise an error if it is used when the balance is below minimum balance' do
      expect {card.touch_in(station)}.to raise_error "Entry denied: Balance below minimum level of #{Oystercard::MINIMUM_BALANCE}"
    end

    it 'is recording the station passenger has boarded the train from' do
        card.top_up(10)
        expect(card.touch_in(station)).to eq(card.entry_station)
    end
  end
  
  describe '#touch_out' do

    it {is_expected.to respond_to(:touch_out)}
    
    it 'let passenger to finish their journey' do
      card.touch_out
      expect(card.in_journey?).to eq false
    end
   
    it "deduct the amount of fare from passenger's card" do
      card.top_up(5)  
      expect {card.touch_out}.to change{card.balance}.by -Oystercard::MINIMUM_BALANCE
    end
  end

  describe '#in_journey?' do
    let(:station) {double :station}
    it{is_expected.to respond_to(:in_journey?)}

    it "confirms the status of the passenger's card when passenger in travelling" do
      card.top_up(20)
      card.touch_in(station)
      expect(card.in_journey?).to eq true  
    end

    it "confirms the status of the passenger's card when passenger has completed journey" do
        card.touch_out
        expect(card.in_journey?).to eq false
    end    
  end  
end