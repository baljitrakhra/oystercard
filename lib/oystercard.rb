class Oystercard
  attr_reader :balance, :in_journey
  MAXIMUM_VALUE = 90
  MINIMUM_BALANCE = 1
  def initialize(balance = 0, maximum_value = MAXIMUM_VALUE)
    @balance = balance 
    @maximum_value = maximum_value
  end

  def top_up(value)
    fail "Balance of card is limited to #{MAXIMUM_VALUE}" if (@balance + value ) > MAXIMUM_VALUE
    @balance = balance + value
  end

  

  def touch_in
    fail "Entry denied: Balance below minimum level of #{MINIMUM_BALANCE}" if @balance < MINIMUM_BALANCE
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    @in_journey = false  
  end

  def in_journey?
    @in_journey
  end

private

  def deduct(amount)
    @balance -= amount
  end
end
