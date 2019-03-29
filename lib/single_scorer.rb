class SingleScorer

  attr_reader :scores

  def initialize
    @scores = [nil] * 10
    @frames = []
    @first_roll = nil
    @pending_frame = nil
  end

  def annotate(fallen_pins)
    if new_frame?
      @pending_frame = Frame.new(fallen_pins)
      if is_strike?(fallen_pins)
        @scores[frames_count] = 10
        close_frame([10])
      else
        @first_roll = fallen_pins
      end
    else
      @pending_frame.second_roll = fallen_pins
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
    @frames.last.is_spare?
  end

  def last_frame_was_strike?
    @frames.last.is_strike?
  end

  def new_frame?
    @pending_frame == nil
  end

  def previous_frame_exists?
    @scores[frames_count - 1]
  end

  def close_frame(frame)
    @frames.push(@pending_frame)
    @pending_frame = nil
  end

end

class Frame

  attr_accessor :first_roll, :second_roll

  def initialize(fallen_pins)
    @first_roll = fallen_pins
    @second_roll = nil
  end

  def is_complete?
    @first_roll == 10 || !@second_roll.nil?
  end

  def is_strike?
    @first_roll == 10
  end

  def is_spare?
    is_complete? && (@first_roll + @second_roll == 10)
  end

  def points
    return 10 if is_strike? or is_spare?
    @first_roll + @second_roll
  end

end