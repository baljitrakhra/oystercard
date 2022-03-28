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
  end
end