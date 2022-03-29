class Oystercard
  attr_reader :balance, :in_journey
  MAXIMUM_VALUE = 90
  def initialize(balance = 0, maximum_value = MAXIMUM_VALUE)
    @balance = balance 
    @maximum_value = maximum_value
  end

  def top_up(value)
    fail "Balance of card is limited to #{MAXIMUM_VALUE}" if (@balance + value ) > MAXIMUM_VALUE
    @balance = balance + value
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false  
  end

  def in_journey?
    @in_journey
  end
end
 