require 'frame'

class SingleScorer

  attr_reader :scores

  def initialize
    @scores = [nil] * 10
    @frames = []
    @current_frame = nil
  end

  def annotate(fallen_pins)
    if first_roll?
      @current_frame = Frame.new(fallen_pins)
      if @current_frame.is_strike?
        annotate_current_frame(10)
        close_frame
      end
    else
      @current_frame.second_roll = fallen_pins
      annotate_current_frame(@current_frame.points)
      if last_frame
        if last_frame.is_strike?
          add_to_previous_frame(@current_frame.points)
        elsif last_frame.is_spare?
          add_to_previous_frame(@current_frame.first_roll)
        end
      end
      close_frame
    end
  end

private

  def frames_count
    @frames.size
  end

  def last_frame
    @frames.last
  end

  def first_roll?
    @current_frame == nil
  end

  def close_frame
    @frames.push(@current_frame)
    @current_frame = nil
  end

  def annotate_current_frame(points)
    @scores[frames_count] = points
  end

  def add_to_previous_frame(points)
    @scores[frames_count - 1] += points
  end

end
