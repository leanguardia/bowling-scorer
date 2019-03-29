class SingleScorer

  def initialize
    @scores = [nil] * 10    
  end
  def scores
    @scores
  end

  def annotate(fallen_pins)
    if @scores[0] == nil
      @scores[0] = fallen_pins 
    else
      @scores[0] += fallen_pins 
    end
  end
  
end