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

  it 'updates board after an open frame' do
    @scorer.annotate('Alice', 4,5);
    score = "Pinfalls\t4\t5\n"+
            "Score\t\t9\n"
    expect( extract_score(@scorer.display) ).to eq (score)
  end

  it 'updates board after spare and open frame' do
    @scorer.annotate('Alice', 5,5, 3,4);
    score = "Pinfalls\t5\t/\t3\t4\n"+
            "Score\t\t13\t7\n"
    expect( extract_score(@scorer.display) ).to eq (score)
  end

  it 'updates board after strike and open frame' do
    @scorer.annotate('Alice', 5,5, 3,4);
    score = "Pinfalls\t5\t/\t3\t4\n"+
            "Score\t\t13\t7\n"
    expect( extract_score(@scorer.display) ).to eq (score)
  end

  it 'updates board after fouls' do
    @scorer.annotate('Alice', 'F',5, 3,'F', 'F','F');
    score = "Pinfalls\tF\t5\t3\tF\tF\tF\n"+
            "Score\t\t5\t3\t0\n"
    expect( extract_score(@scorer.display) ).to eq (score)
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

def extract_score(board)
  lines = board.scan(/[^\n]*\n/)
  lines[2] + lines[3] 
end