require 'bowling_scorer'

RSpec.describe BowlingScorer do
  
  it 'displays empty scoreboard for one player' do
    scorer = BowlingScorer.new
    scorer.add_player('Alice')
    expect(scorer.display)
    .to eq ("Frame\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\n"+
      "Alice\n"+
      "Pinfalls\t\n"+
      "Score\t\n")
  end
    
end