class Frame

  attr_accessor :first_roll, :second_roll, :bonus
  
  def initialize(fallen_pins)
    @first_roll = fallen_pins
    @second_roll = nil
    @bonus = 0
  end
  
  def is_complete?
    @first_roll == 10 || !@second_roll.nil?
  end
  
  def is_strike?
    @first_roll == 10
  end
  
  def is_spare?
    is_complete? && !is_strike? && (@first_roll + @second_roll == 10)
  end
  
  def points
    return 10 + bonus if is_strike? || is_spare?
    @first_roll + @second_roll
  end
  
end
