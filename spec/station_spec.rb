require_relative '../lib/station'

describe 'Station' do
  
  station = Station.new("Paddington","one")
  
  describe 'initializes station with name and zone' do
    it 'add name to the station' do
      expect(station.name).to eq "Paddington"
    end
    it 'add zone to the station' do
      expect(station.zone).to eq "one"
    end
  end
end
