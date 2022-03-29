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

  describe '#deduct' do
    
    it {is_expected.to respond_to(:deduct).with(1).argument}

    it 'reduces the balance by certain amount' do
      expect {card.deduct 20}.to change {card.balance}.by -20

    end
  end

  describe '#touch_in' do
    
    it {is_expected.to respond_to(:touch_in)}

    it 'let the passenger to start the journey' do
       card.touch_in
       expect(card.in_journey).to eq true
    end 
  end
  
  describe '#touch_out' do

    it {is_expected.to respond_to(:touch_out)}
    
    it 'let passenger to finish their journey' do
      card.touch_out
      expect(card.in_journey).to eq false
    end

  end

  describe '#in_journey?' do

    it{is_expected.to respond_to(:in_journey?)}

    it "confirms the status of the passenger's card when passenger in travelling" do
      card.touch_in
      expect(card.in_journey?).to eq true  
    end

    it "confirms the status of the passenger's card when passenger has completed journey" do
        card.touch_out
        expect(card.in_journey?).to eq false
    end    
  end  
end