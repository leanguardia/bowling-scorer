require 'roll'

class Frame

  attr_accessor :bonus
  
  def initialize(fallen_pins)
    @rolls = [Roll.new(fallen_pins)]
    @bonus = 0
  end
  
  def is_complete?
    first_roll_pins == 10 || second_roll
  end
  
  def is_strike?
    first_roll_pins == 10
  end
  
  def is_spare?
    second_roll && !is_strike? && (first_roll_pins + second_roll_pins == 10)
  end

  def add_roll(fallen_pins)
    @rolls.push(Roll.new(fallen_pins))
  end

  def points
    first_roll_pins + second_roll_pins
  end
  
  def total_points
    points + bonus
  end

  def verify_spare_bonus(previous)
    previous.bonus += first_roll_pins if previous && previous.is_spare?
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
    return [first_roll.to_string, '/'] if is_spare?
    [first_roll.to_string, second_roll.to_string]
  end

private

  def first_roll
    @rolls[0]
  end

  def first_roll_pins
    first_roll.pins
  end

  def second_roll
    @rolls[1]
  end

  def second_roll_pins
    second_roll ? @rolls[1].pins : 0
  end
  
end

class TenthFrame < Frame

  def is_complete?
    !is_strike? && second_roll && !is_spare? || third_roll
  end

  def add_roll(fallen_pins)
    super(fallen_pins)
    verify_bonuses_with_itself if @rolls.size == 3
  end

  def to_strings
    strings = [ first_roll.to_string ]
    is_spare? ? strings.push('/') : strings.push(second_roll.to_string)
    strings.push(third_roll.to_string) if third_roll
    strings
  end

private

  def verify_bonuses_with_itself
    Frame.new(third_roll_pins).verify_spare_bonus(self)
    Frame.new(third_roll_pins).verify_strike_bonus(self, nil)
  end

  def third_roll
    @rolls[2]
  end

  def third_roll_pins
    third_roll.pins
  end

end
