class BowlingScorer

  def initialize
    @players = []
  end

  def add_player(player_name)
    @players.push(player_name)
  end

  def display
    board = "Frame\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\n"
    @players.each do |player_name| 
      board += "#{player_name}\n"+
               "Pinfalls\t\n"+
               "Score\t\n"
    end
    board
  end

end