require 'frame'

class SingleScorer

  attr_reader :scores

  def initialize
    @scores = [nil] * 10
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
      @scores[frames_count] = @current_frame.points
      check_bonus_points
      complete_frame
    end
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
        @scores[frames_count - 1] += @current_frame.points
        if second_last_frame && second_last_frame.is_strike?
          @scores[frames_count - 2] += 10
        end
      elsif last_frame.is_spare?
        @scores[frames_count - 1] += @current_frame.first_roll
      end
    end
  end

end
