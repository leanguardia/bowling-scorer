class SingleScorer

  def initialize
    @scores = [nil] * 10
    @frames = 0
  end
  def scores
    @scores
  end

  def annotate(fallen_pins)
    if @scores[@frames] == nil
      @scores[@frames] = fallen_pins
    else
      @scores[@frames] += fallen_pins
      @frames += 1
    end
  end
  
end