class Frame

  attr_accessor :first_roll, :second_roll
  
  def initialize(fallen_pins)
    @first_roll = fallen_pins
    @second_roll = nil
  end
  
  def is_complete?
    @first_roll == 10 || !@second_roll.nil?
  end
  
  def is_strike?
    @first_roll == 10
  end
  
  def is_spare?
    is_complete? && (@first_roll + @second_roll == 10)
  end
  
  def points
    return 10 if is_strike? or is_spare?
    @first_roll + @second_roll
  end
  
end
