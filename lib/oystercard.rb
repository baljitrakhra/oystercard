class Oystercard
  attr_reader :balance
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
end
 