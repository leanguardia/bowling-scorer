require_relative 'frame'

class SingleScorer

  attr_reader :player_name

  def initialize(player_name)
    @player_name = player_name
    @frames = []
    @current_frame = nil
  end

  def annotate(fallen_pins)
    if is_new_frame?
      @current_frame = create_new_frame(fallen_pins)
      @current_frame.verify_spare_bonus(previous_frame)
    else
      @current_frame.add_roll(fallen_pins)
    end
    if @current_frame.is_complete?
      @current_frame.verify_strike_bonus(previous_frame, second_previous_frame)
      confirm_frame
    end
  end

  def scores
    @frames.map { |frame| frame.total_points }
  end

  def cumulative_scores
    sum = 0
    scores.map { |points| sum += points }
  end

  def parse_rolls
    @frames.map { |frame| frame.to_strings }.flatten
  end

private

  def is_new_frame?
    @current_frame == nil
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

  def create_new_frame(fallen_pins)
    if @frames.size == 9
      new_frame = TenthFrame.new(fallen_pins)
    elsif 
      new_frame = Frame.new(fallen_pins)
    end
    new_frame
  end

end
