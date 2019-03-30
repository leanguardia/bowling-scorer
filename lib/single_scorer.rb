require 'frame'

class SingleScorer

  def initialize
    @frames = []
    @current_frame = nil
  end

  def annotate(fallen_pins)
    if is_new_frame?
      @current_frame = Frame.new(fallen_pins)
    else
      @current_frame.second_roll = fallen_pins
    end
    if @current_frame.is_complete?
      check_bonus_points
      complete_frame
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

  def last_frame
    @frames[-1]
  end

  def second_last_frame
    @frames[-2]
  end

  def complete_frame
    @frames.push(@current_frame)
    @current_frame = nil
  end

  def check_bonus_points
    if last_frame
      if last_frame.is_strike?
        last_frame.bonus += @current_frame.points
        if second_last_frame && second_last_frame.is_strike?
          second_last_frame.bonus += 10
        end
      elsif last_frame.is_spare?
        last_frame.bonus += @current_frame.first_roll
      end
    end
  end

end
