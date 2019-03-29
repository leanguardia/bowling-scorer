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

  it 'calculates 10 points by falling 3 and 7 pins (spare)' do
    @scorer.annotate(3)
    @scorer.annotate(7)
    expect(@scorer.scores)
      .to eq([10, nil, nil, nil, nil, nil, nil, nil, nil, nil])
  end

end