class Frame

  attr_accessor :bonus
  
  def initialize(fallen_pins)
    @first_roll = fallen_pins
    @bonus = 0
  end
  
  def is_complete?
    @first_roll == 10 || !@second_roll.nil?
  end
  
  def is_strike?
    @first_roll == 10
  end
  
  def is_spare?
    @second_roll && !is_strike? && (@first_roll + @second_roll == 10)
  end

  def add_roll(fallen_pins)
    @second_roll = fallen_pins
  end

  def points
    @first_roll + (@second_roll || 0)
  end
  
  def total_points
    points + bonus
  end

  def verify_spare_bonus(previous)
    previous.bonus += @first_roll if previous && previous.is_spare?
  end

  def verify_strike_bonus(previous, second_previous)
    if previous && previous.is_strike?
      previous.bonus += self.points
      if second_previous && second_previous.is_strike?
        second_previous.bonus += 10
      end
    end
  end

  def to_strings
    return ['', 'X'] if is_strike?
    return [@first_roll.to_s, '/'] if is_spare?
    [@first_roll.to_s, @second_roll.to_s]
  end

  def parse_roll(roll)
    roll == 10 ? 'X' : roll.to_s
  end
  
end

class TenthFrame < Frame

  def is_complete?
    !is_strike? && @second_roll && !is_spare? || @third_roll
  end

  def add_roll(fallen_pins)
    if @second_roll.nil?
      @second_roll = fallen_pins
    else
      @third_roll = fallen_pins
      verify_bonuses_with_itself
    end
  end

  def verify_bonuses_with_itself
    Frame.new(@third_roll).verify_spare_bonus(self)
    Frame.new(@third_roll).verify_strike_bonus(self, nil)
  end

  def to_strings
    strings = [ parse_roll(@first_roll) ]
    is_spare? ? strings.push('/') : strings.push(parse_roll(@second_roll))
    strings.push(parse_roll(@third_roll)) if @third_roll  
    strings
  end
end