require 'single_scorer'

RSpec.describe SingleScorer do
  
  it 'initializes with a list of empty scores' do
    game = SingleScorer.new
    scores = game.scores
    expect(scores).to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil, nil])
  end

end