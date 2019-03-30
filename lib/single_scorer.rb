require 'frame'

class SingleScorer

  def initialize
    @frames = []
    @current_frame = nil
  end

  def annotate(fallen_pins)
    if is_new_frame?
      @current_frame = Frame.new(fallen_pins)
      check_spare_bonus
    else
      @current_frame.second_roll = fallen_pins
    end
    if @current_frame.is_complete?
      check_strike_bonus
      confirm_frame
    end
  end

  def scores
    @frames.map { |frame| frame.points }.take(10)
  end

private

  def is_new_frame?
    @current_frame == nil
  end

  def frames_count
    @frames.size
  end

  def previous_frame
    @frames[-1]
  end

  def second_previous_frame
    @frames[-2]
  end

  def confirm_frame
    @frames.push(@current_frame)
    @current_frame = nil
  end

  def check_spare_bonus
    if previous_frame && previous_frame.is_spare?
      previous_frame.bonus += @current_frame.first_roll
    end
  end
  
  def check_strike_bonus
    if previous_frame && previous_frame.is_strike?
      previous_frame.bonus += @current_frame.points
      if second_previous_frame && second_previous_frame.is_strike?
        second_previous_frame.bonus += 10
      end
    end
  end

end
