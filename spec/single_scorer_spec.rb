require 'single_scorer'

RSpec.describe SingleScorer do

  before(:each) do
    @scorer = SingleScorer.new('Alice')
  end
  
  it 'belongs to a player' do
    expect(@scorer.player_name).to eq('Alice')
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
    expect(@scorer.scores).to eq([29, 20, 10])
  end

  it 'calculates 30 and 20 points on the first two frames after three strikes' do
    annotateAll(10, 10, 10)
    expect(@scorer.scores).to eq([30, 20, 10])
  end  

  it 'calculates scores for frames with fouls' do
    annotateAll('F',6, 3,'F', 'F','F')
    expect(@scorer.scores).to eq([6, 3, 0])
  end

  it 'calculates scores for worst game' do
    annotateAll(0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0)
    expect(@scorer.scores).to eq([0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
  end

  it 'calculates scores after 10th frame spare' do
    annotateAll(1,1, 2,2, 3,3, 4,4, 5,5, 6,3, 5,2, 4,1, 3,0, 2,8,5)
    expect(@scorer.scores).to eq([2, 4, 6, 8, 16, 9, 7, 5, 3, 15])
  end

  it 'calculates scores for a perfect game' do
    annotateAll(10, 10, 10, 10, 10, 10, 10, 10, 10, 10,10,10)
    expect(@scorer.scores).to eq([30, 30, 30, 30, 30, 30, 30, 30, 30, 30])
  end

  it 'calculates cummulative scores' do
    annotateAll(3,4, 5,5, 6,2, 1,2, 3,5, 3,2, 1,2, 10, 5,2, 1,0)
    expect(@scorer.scores)
      .to eq [7, 16, 8, 3, 8, 5, 3, 17, 7, 1]
    expect(@scorer.cumulative_scores)
      .to eq([7, 23, 31, 34, 42, 47, 50, 67, 74, 75])
  end

  it 'parses rolls to list of strings' do
    annotateAll(3,4, 5,5, 6,2, 'F',2, 3,'F', 0,10, 'F','F', 10, 5,2, 1,0)
    expect(@scorer.parse_rolls)
      .to eq(['3','4', '5','/', '6','2', 'F','2', '3','F',
              '0','/', 'F','F', '','X', '5','2', '1','0'])
  end

  it 'parses tenth frame with a spare and extra roll' do
    annotateAll(0,0, 9,1, 6,2, 1,2, 3,5, 3,2, 1,2, 10, 5,2, 0,10,9)
    expect(@scorer.parse_rolls)
      .to eq(['0','0', '9','/', '6','2', '1','2', '3','5',
              '3','2', '1','2', '','X', '5','2', '0','/','9'])
  end

  it 'parses tenth frame with strike and extra rolls' do
    annotateAll(10, 7,3, 9,0, 10, 0,8, 8,2, 0,6, 10, 10, 10,8,1)
    expect(@scorer.parse_rolls)
      .to eq(['','X', '7','/', '9','0', '','X', '0','8',
              '8','/', '0','6', '','X', '','X', 'X','8','1'])
  end

  it 'parses tenth frame with two strikes and extra roll' do
    annotateAll(3,4, 5,5, 6,2, 1,2, 3,5, 3,2, 1,2, 10, 5,2, 10,10,3)
    expect(@scorer.parse_rolls)
      .to eq(['3','4', '5','/', '6','2', '1','2', '3','5',
              '3','2', '1','2', '','X', '5','2', 'X','X','3'])
  end

  it 'parses tenth frame with three strikes' do
    annotateAll(0,0, 9,1, 6,2, 1,2, 3,5, 3,2, 1,2, 10, 5,2, 10,10,10)
    expect(@scorer.parse_rolls)
      .to eq(['0','0', '9','/', '6','2', '1','2', '3','5',
              '3','2', '1','2', '','X', '5','2', 'X','X','X'])
  end

end

def annotateAll(*fallen_pins_list)
  fallen_pins_list.each { |pins| @scorer.annotate(pins) }
end
