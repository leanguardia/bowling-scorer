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

  it 'calculates 10 points after falling 10 pins (strike)' do
    @scorer.annotate(10)
    expect(@scorer.scores)
      .to eq([10, nil, nil, nil, nil, nil, nil, nil, nil, nil])
  end

  it 'calculates 18 points after a strike and falling 3 and 5 pins' do
    @scorer.annotate(10)
    @scorer.annotate(3)
    @scorer.annotate(5)
    expect(@scorer.scores)
      .to eq([18, 8, nil, nil, nil, nil, nil, nil, nil, nil])
  end

  it 'calculates 20 points on a spare frame after a consecutive strike' do
    @scorer.annotate(5)
    @scorer.annotate(5)
    @scorer.annotate(10)
    expect(@scorer.scores)
      .to eq([20, 10, nil, nil, nil, nil, nil, nil, nil, nil])
  end

  it 'calculates 20 points on the first frame after two strikes' do
    @scorer.annotate(10)
    @scorer.annotate(10)
    expect(@scorer.scores)
      .to eq([20, 10, nil, nil, nil, nil, nil, nil, nil, nil])
  end

  it 'calculates 30 and 20 points on the first two frames after three strikes' do
    @scorer.annotate(10)
    @scorer.annotate(10)
    @scorer.annotate(10)
    expect(@scorer.scores)
      .to eq([30, 20, 10, nil, nil, nil, nil, nil, nil, nil])
  end

end