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
    pinfalls = join_with_tabs("Pinfalls", "4","5\n")
    scores =   join_with_tabs("Score\t",  "9\n")    
    evaluate_pinfalls_and_scores(pinfalls, scores)
  end

  it 'updates board after spare and open frame' do
    @scorer.annotate('Alice', 5,5, 3,4);
    pinfalls = join_with_tabs("Pinfalls", "5", "/", "3", "4\n")
    scores =   join_with_tabs("Score\t",  "13",     "20\n")
    evaluate_pinfalls_and_scores(pinfalls, scores)
  end

  it 'updates board after strike and open frame' do
    @scorer.annotate('Alice', 5,5, 3,4);
    pinfalls = join_with_tabs("Pinfalls", "5", "/", "3", "4\n")
    scores =   join_with_tabs("Score\t",  "13",     "20\n")
    evaluate_pinfalls_and_scores(pinfalls, scores)
  end

  it 'updates board after fouls' do
    @scorer.annotate('Alice', 'F',5, 3,'F', 'F','F');
    pinfalls = join_with_tabs("Pinfalls", "F","5", "3","F", "F","F\n")
    scores =   join_with_tabs("Score\t",  "5",     "8",     "8\n")
    evaluate_pinfalls_and_scores(pinfalls, scores)
  end

  it 'updates board after complete game' do
    @scorer.annotate('Alice', 0,1, 2,3, 4,5, 6,3, 7,2, 10, 10, 'F',3, 9,0, 3,3);
    pinfalls = join_with_tabs("Pinfalls", "0","1", "2", "3","4","5", "6","3", "7","2", "","X", "","X", "F","3", "9","0", "3","3\n")
    scores =    join_with_tabs("Score\t", "1",     "6",     "15",    "24",    "33",    "63",   "76",   "79",    "88",    "94\n")
    evaluate_pinfalls_and_scores(pinfalls, scores)
  end

  it 'updates board after game with special tenth frame' do
    @scorer.annotate('Alice', 0,1, 2,3, 4,5, 6,4, 7,2, 10, 10, 'F',3, 9,0, 3,7,'F');
    pinfalls = join_with_tabs("Pinfalls", "0","1", "2","3", "4","5", "6","/", "7","2", "","X", "","X", "F","3", "9","0", "3","/","F\n")
    scores =   join_with_tabs("Score\t",  "1",     "6",     "15",    "32",    "41",    "71",   "84",   "87",    "96",    "106\n")
    evaluate_pinfalls_and_scores(pinfalls, scores)
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
    expect(board).to eq (board)
  end

end

def evaluate_pinfalls_and_scores(pinfalls, scores)
  board = @scorer.display
  expect( extract_pinfalls(board) ).to eq (pinfalls)
  expect( extract_score(board) ).to eq (scores)
end

def join_with_tabs(*elements)
  elements.join("\t")
end

def extract_pinfalls(board)
  extract_line(2, board)
end

def extract_score(board)
  extract_line(3, board)
end

def extract_line(line, board)
  split_lines(board)[line]
end

def split_lines(board)
  board.scan(/[^\n]*\n/)
end