class Roll

  def initialize(fallen_pins)
    @is_foul = fallen_pins == 'F'
    @fallen_pins = is_foul? ? 0 : fallen_pins
  end

  def pins
    @fallen_pins
  end

  def is_foul?
    @is_foul
  end

  def to_string
    if is_foul? 
      return 'F'
    elsif @fallen_pins == 10
      return 'X'
    end
    @fallen_pins.to_s
  end

end