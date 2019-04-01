require 'bowling_scorer'

RSpec.describe BowlingScorer do

  before(:each) do
    @scorer = BowlingScorer.new
    @scorer.add_player('Alice')
  end

  it 'displays empty scoreboard for one player' do
    board = join_with_tabs(2, %w[Frame 1 2 3 4 5 6 7 8 9 10]) + "\n" +
            "Alice\n"+
            "Pinfalls\n"+
            "Score\n"
    expect(@scorer.display).to eq (board)
  end

  it 'updates board after an open frame' do
    @scorer.annotate('Alice', 4,5);
    board = @scorer.display
    expect(extract_pinfalls(board)).to eq (parse_pinfalls( "4","5"))
    expect(extract_score(board)).to    eq (parse_scores(   "9"))
  end

  it 'updates board after spare and open frame' do
    @scorer.annotate('Alice', 5,5, 3,4)
    board = @scorer.display
    expect( extract_pinfalls(board) ).to eq (parse_pinfalls( "5","/", "3","4"))
    expect( extract_score(board) ).to    eq (parse_scores(   "13",     "20"))
  end

  it 'updates board after strike and open frame' do
    @scorer.annotate('Alice', 5,5, 3,4)
    board = @scorer.display
    expect( extract_pinfalls(board) ).to eq (parse_pinfalls( "5","/", "3","4"))
    expect( extract_score(board) ).to    eq (parse_scores(   "13",    "20"))
  end

  it 'updates board after fouls' do
    @scorer.annotate('Alice', 'F',5, 3,'F', 'F','F')
    board = @scorer.display
    expect( extract_pinfalls(board) ).to eq (parse_pinfalls( "F","5", "3","F", "F","F"))
    expect( extract_score(board) ).to    eq (parse_scores(   "5",     "8",     "8"))
  end

  it 'updates board after complete game' do
    @scorer.annotate('Alice', 0,1, 2,3, 4,5, 6,3, 7,2, 10, 10, 'F',3, 9,0, 3,3);
    pinfalls = parse_pinfalls( "0","1", "2","3", "4","5", "6","3", "7","2", "","X", "","X", "F","3", "9","0", "3","3")
    scores =   parse_scores(   "1",     "6",     "15",    "24",    "33",    "53",   "66",   "69",    "78",    "84")
    board = @scorer.display
    expect( extract_pinfalls(board) ).to eq (pinfalls)
    expect( extract_score(board) ).to eq (scores)
  end

  it 'updates board after game with special tenth frame' do
    @scorer.annotate('Alice', 0,1, 2,3, 4,5, 6,4, 7,2, 10, 10, 'F',3, 9,0, 3,7,'F');
    pinfalls = parse_pinfalls( "0","1", "2","3", "4","5", "6","/", "7","2", "","X", "","X", "F","3", "9","0", "3","/","F")
    scores =   parse_scores(   "1",     "6",     "15",    "32",    "41",    "61",   "74",   "77",    "86",    "96")
    board = @scorer.display
    expect( extract_pinfalls(board) ).to eq (pinfalls)
    expect( extract_score(board) ).to eq (scores)
  end

  it 'displays empty scoreboard for many players' do
    @scorer.add_player('Bob')
    @scorer.add_player('Camila')
    board = join_with_tabs(2, %w[Frame 1 2 3 4 5 6 7 8 9 10]) + "\n" +
            "Alice\n"+
            "Pinfalls\n"+
            "Score\n"+
            "Bob\n"+
            "Pinfalls\n"+
            "Score\n"+
            "Camila\n"+
            "Pinfalls\n"+
            "Score\n"
    expect(@scorer.display).to eq (board)
  end
  
  it 'updates board with complete games of many players' do
    @scorer.annotate('Alice', 0,1, 2,3, 4,5, 6,4, 7,2, 10, 10, 'F',3, 9,0, 3,7,'F');
    @scorer.add_player('Jeff')
    @scorer.annotate('Jeff', 10, 7,3, 9,0, 10, 0,8, 8,2, 'F',6, 10, 10, 10,8,1);
    @scorer.add_player('John')
    @scorer.annotate('John', 3,7, 6,3, 10, 8,1, 10, 10, 9,0, 7,3, 4,4, 10,9,0);
    board = join_with_tabs(2, %w[Frame 1 2 3 4 5 6 7 8 9 10]) + "\n" +
            "Alice\n"+
            parse_pinfalls( "0","1", "2","3", "4","5", "6","/", "7","2", "","X", "","X", "F","3", "9","0", "3","/","F")+
            parse_scores(   "1",     "6",     "15",    "32",    "41",    "61",   "74",   "77",    "86",    "96")+
            "Jeff\n"+
            parse_pinfalls( "","X", "7","/", "9","0", "","X", "0","8", "8","/", "F","6" ,"","X", "","X", "X","8","1")+
            parse_scores(   "20",   "39",    "48",    "66",   "74",    "84",    "90",    "120","148","167")+
            "John\n"+
            parse_pinfalls( "3","/", "6","3", "","X", "8","1", "","X", "","X", "9","0" ,"7","/", "4","4", "X","9","0")+
            parse_scores(   "16",   "25",    "44",    "53",   "82",    "101",  "110",   "124",   "132",   "151")
    expect(@scorer.display).to eq (board)
  end

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

def parse_pinfalls(*rolls_list) 
  join_with_tabs(1, ["Pinfalls"] + rolls_list) + "\n"
end

def parse_scores(*rolls_list) 
  join_with_tabs(2, ["Score"] + rolls_list) + "\n"
end

def join_with_tabs(tabs_number, *elements)
  elements.join("\t" * tabs_number)
end
