class Oystercard
  DEFAULT_LIMIT = 90.0
  MINIMUM_FARE = 1.0
  attr_reader :balance, :entry_station, :exit_station, :list_of_journeys, :journey_touch

  def initialize()
    @balance = 0.0
    @entry_station = nil
    @exit_station = nil
    @list_of_journeys = []
    @journey_touch = Journey.new
  end

  def top_up(amount)
    raise "Cannot exceed #{DEFAULT_LIMIT} limit" if @balance + amount.to_f > DEFAULT_LIMIT
    @balance += amount.to_f
  end


  def touch_in(station)
    raise "Below minimum fare" if @balance < MINIMUM_FARE
    journey_touch = Journey.new(station)
    @entry_station = station # I think this need to go as well 
  end

  def touch_out(station)
    self.deduct(MINIMUM_FARE) #this need to go into fare
    journey_touch.end_journey(station)
    @exit_station = station
    add_journey
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount.to_f
  end

  def add_journey
    journey = {entry_station: @entry_station, exit_station: @exit_station}
    list_of_journeys.push(journey)
  end
end
