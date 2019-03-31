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
            "Score\t\t\n"
    expect(@scorer.display).to eq (board)
  end

  it 'updates pinfalls and score after a frame' do
    @scorer.annotate('Alice', 4,5);
    board = "Frame\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\n"+
            "Alice\n"+
            "Pinfalls\t4\t5\n"+
            "Score\t\t9\n"
    expect(@scorer.display).to eq (board)
  end

  it 'displays empty scoreboard for many players' do
    @scorer.add_player('Bob')
    @scorer.add_player('Camila')
    board = "Frame\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\n"+
            "Alice\n"+
            "Pinfalls\t\n"+
            "Score\t\t\n"+
            "Bob\n"+
            "Pinfalls\t\n"+
            "Score\t\t\n"+
            "Camila\n"+
            "Pinfalls\t\n"+
            "Score\t\t\n"
    expect(@scorer.display).to eq (board)
  end
    
end