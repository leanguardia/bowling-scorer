class SingleScorer

  attr_reader :scores

  def initialize
    @scores = [nil] * 10
    @frames = []
    @first_roll = nil
  end

  def annotate(fallen_pins)
    if new_frame?
      if is_strike?(fallen_pins)
        @scores[frames_count] = 10
        close_frame([10])
      else
        @first_roll = fallen_pins
      end
    else
      if previous_frame_exists?
        if last_frame_was_strike?
          @scores[frames_count - 1] += @first_roll + fallen_pins
        elsif last_frame_was_spare?
          @scores[frames_count - 1] += @first_roll
        end
      end
      @scores[frames_count] = @first_roll + fallen_pins
      close_frame([@first_roll, fallen_pins])
    end
  end

private

  def frames_count
    @frames.size
  end

  def is_strike?(fallen_pins)
    fallen_pins == 10
  end

  def last_frame_was_spare?
    @frames.last[0] + @frames.last[1] == 10
  end

  def last_frame_was_strike?
    @frames.last[0] == 10
  end

  def new_frame?
    @first_roll == nil
  end

  def previous_frame_exists?
    @scores[frames_count - 1]
  end

  def close_frame(frame)
    @first_roll = nil
    @frames.push(frame)
  end

end