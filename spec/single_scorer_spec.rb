require 'single_scorer'

RSpec.describe SingleScorer do

  before(:each) do
    @scorer = SingleScorer.new
  end
  
  it 'initializes with a list of empty scores' do
    expect(@scorer.scores).to eq([])
  end

  it 'calculates 7 points by falling 3 and 4 pins' do
    annotateAll(3, 4)
    expect(@scorer.scores).to eq([7])
  end

  it 'calculates 9 points by falling 5 and 4 pins on the second frame' do
    annotateAll(3, 4, 5, 4)
    expect(@scorer.scores).to eq([7, 9])
  end

  it 'calculates 10 points by falling 3 and 7 pins (spare)' do
    annotateAll(3, 7)
    expect(@scorer.scores).to eq([10])
  end

  it 'calculates 16 points after a spare and falling 6 pins' do
    annotateAll(3, 7, 6, 3)
    expect(@scorer.scores).to eq([16, 9])
  end

  it 'calculates 10 points after falling 10 pins (strike)' do
    @scorer.annotate(10)
    expect(@scorer.scores).to eq([10])
  end

  it 'calculates 18 points after a strike and falling 3 and 5 pins' do
    annotateAll(10, 3, 5)
    expect(@scorer.scores).to eq([18, 8])
  end

  it 'calculates 20 points on a spare frame after a strike' do
    annotateAll(5, 5, 10)
    expect(@scorer.scores).to eq([20, 10])
  end

  it 'calculates 20 points on the first frame after two strikes' do
    annotateAll(10, 10)
    expect(@scorer.scores).to eq([20, 10])
  end

  it 'calculates 30 and 20 points on the first two frames after two strikes and a spare' do
    annotateAll(10, 10, 9, 1)
    expect(@scorer.scores).to eq([30, 20, 10])
  end

  it 'calculates 30 and 20 points on the first two frames after three strikes' do
    annotateAll(10, 10, 10)
    expect(@scorer.scores).to eq([30, 20, 10])
  end

  it 'calculates scores for worst game' do
    annotateAll(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    expect(@scorer.scores).to eq([0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
  end

  it 'calculates scores after 10th frame spare' do
    annotateAll(1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 3, 5, 2, 4, 1, 3, 0, 2, 8, 5)
    expect(@scorer.scores).to eq([2, 4, 6, 8, 16, 9, 7, 5, 3, 15])
  end

  it 'calculates scores for a perfect game' do
    annotateAll(10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10)
    expect(@scorer.scores).to eq([30, 30, 30, 30, 30, 30, 30, 30, 30, 30])
  end

end

def annotateAll(*fallen_pins_list)
  fallen_pins_list.each { |pins| @scorer.annotate(pins) }
end
