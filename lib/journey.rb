class Journey
  attr_reader :entry_station, :exit_station
  PENALITY_FARE = 6
  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
    
  end

  def end_journey(station)
    @exit_station = station
    @entry_station = nil
  end

  def complete?
    entry_station == nil ? true : false
  end

  def fare
    p complete?
    if complete?
      Oystercard::MINIMUM_FARE
    else 
      PENALITY_FARE
    end
  end
end