require 'single_scorer'

RSpec.describe SingleScorer do

  before(:each) do
    @scorer = SingleScorer.new
  end
  
  it 'initializes with a list of empty scores' do
    expect(@scorer.scores)
      .to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil, nil])
  end

  it 'calculates 7 points by falling 3 and 4 pins' do
    @scorer.annotate(3)
    @scorer.annotate(4)
    expect(@scorer.scores)
      .to eq([7, nil, nil, nil, nil, nil, nil, nil, nil, nil])
  end

  it 'calculates 9 points by falling 5 and 4 pins on the second frame' do
    @scorer.annotate(3)
    @scorer.annotate(4)
    @scorer.annotate(5)
    @scorer.annotate(4)
    expect(@scorer.scores)
      .to eq([7, 9, nil, nil, nil, nil, nil, nil, nil, nil])
  end

  it 'calculates 10 points by falling 3 and 7 pins (spare)' do
    @scorer.annotate(3)
    @scorer.annotate(7)
    expect(@scorer.scores)
      .to eq([10, nil, nil, nil, nil, nil, nil, nil, nil, nil])
  end

  it 'calculates 16 points after a spare and falling 6 pins' do
    @scorer.annotate(3)
    @scorer.annotate(7)
    @scorer.annotate(6)
    @scorer.annotate(3)
    expect(@scorer.scores)
      .to eq([16, 9, nil, nil, nil, nil, nil, nil, nil, nil])
  end

end