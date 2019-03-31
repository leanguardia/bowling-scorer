require 'single_scorer'

class BowlingScorer

  def initialize
    @players = {}
  end

  def add_player(player)
    @players[player] = SingleScorer.new(player)
  end

  def display
    board = "Frame\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\n"
    @players.keys.each do |player|
      board += "#{player}\n"+
               "Pinfalls\t#{parse_rolls_for(player)}\n"+
               "Score\t\t#{parse_scores_for(player)}\n"
    end
    board
  end

  def annotate(player, *fallen_pins)
    fallen_pins.each do |pins|
      @players[player].annotate(pins)
    end
  end

private

  def parse_rolls_for(player)
    @players[player].parse_rolls.reduce {|line, roll| line + "\t" + roll}
  end

  def parse_scores_for(player)
    @players[player].cumulative_scores.reduce {|line, score| line.to_s + "\t" + score.to_s }
  end

end