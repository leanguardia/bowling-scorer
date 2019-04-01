require_relative 'single_scorer'

class BowlingScorer

  def initialize
    @players = {}
  end

  def add_player(player)
    @players[player] = SingleScorer.new(player)
  end

  def display
    board = parse(data: %w[Frame 1 2 3 4 5 6 7 8 9 10], tab_number: 2)
    players.each do |player|
      board += player + line_break +
            parse(data: ['Pinfalls'] + rolls_for(player), tab_number: 1) +
            parse(data: ['Score'] + scores_for(player), tab_number: 2)
    end
    board
  end

  def players
    @players.keys
  end

  def annotate(player, *fallen_pins)
    fallen_pins.each { |pins| @players[player].annotate(pins) }
  end

private

  def rolls_for(player)
    @players[player].parse_rolls
  end

  def scores_for(player)
    @players[player].cumulative_scores.map{|s| s.to_s}
  end

  def parse(data: elements, tab_number: n = 0)
    data.join("\t" * tab_number) + line_break
  end

  def line_break
    "\n"
  end

end