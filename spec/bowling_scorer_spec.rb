require 'bowling_scorer'

RSpec.describe BowlingScorer do

  before(:each) do
    @scorer = BowlingScorer.new
    @scorer.add_player('Alice')
  end

  it 'displays empty scoreboard for one player' do
    board = "Frame\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\n"+
            "Alice\n"+
            "Pinfalls\t\n"+
            "Score\t\n"
    expect(@scorer.display).to eq (board)
  end

  it 'displays empty scoreboard for many players' do
    @scorer.add_player('Bob')
    @scorer.add_player('Camila')
    board = "Frame\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\n"+
            "Alice\n"+
            "Pinfalls\t\n"+
            "Score\t\n"+
            "Bob\n"+
            "Pinfalls\t\n"+
            "Score\t\n"+
            "Camila\n"+
            "Pinfalls\t\n"+
            "Score\t\n"
    expect(@scorer.display).to eq (board)
  end
    
end