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
      @first_roll = fallen_pins
    else
      if previous_frame_exists? && @scores[@frames - 1] == 10
        @scores[@frames - 1] += @first_roll
      end
      @scores[@frames] = @first_roll + fallen_pins
      close_frame
    end
  end

private

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