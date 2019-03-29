class SingleScorer

  def initialize
    @scores = [nil] * 10
    @frames = 0
    @first_roll = nil
  end
  def scores
    @scores
  end

  def annotate(fallen_pins)
    if new_frame?
      if is_strike?(fallen_pins)
        @scores[@frames] = 10
        close_frame
      else
        @first_roll = fallen_pins
      end
    else
      if previous_frame_exists? && last_frame_was_spare?
        @scores[@frames - 1] += @first_roll
      end
      @scores[@frames] = @first_roll + fallen_pins
      close_frame
    end
  end

private

  def is_strike?(fallen_pins)
    fallen_pins == 10
  end

  def last_frame_was_spare?
    @scores[@frames - 1] == 10
  end

  def new_frame?
    @first_roll == nil
  end

  def previous_frame_exists?
    @scores[@frames - 1]
  end

  def close_frame
    @first_roll = nil
    @frames += 1
  end

end