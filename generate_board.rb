require_relative 'lib/bowling_scorer'
require 'optparse'

help_message = "Usage: ruby print_board.rb -i INPUT_FILE"

def print_separator
  puts '-' * 177
end

def log(info)
  puts info
end

def register_roll(games, input_line)
  player, fallen_pins = input_line.split(' ')
  games.has_key?(player) ? games[player].push(fallen_pins) : games[player] = [fallen_pins]
end

def execute_bowling_scoreboard(file)
  log("Bowling Scoreboard")
  log("Loading game from '#{file}'")
  
  @games = {}
  File.readlines(file).each { |line| register_roll(@games, line) }
  log("Number of players: #{@games.size}")
  
  @scorer = BowlingScorer.new
  @games.keys.each do |player|
    log("Registering rolls for: #{player}")
    @scorer.add_player(player)
    @scorer.annotate(player, @games[player].map {|roll| roll.to_i})
  end

  print_separator
  log(@scorer.display)
  print_separator
end

OptionParser.new do |parser|
  parser.banner = help_message
  parser.on("-i", "--input FILE", "Load input file to calculate scoreboard") do |file|
    execute_bowling_scoreboard(file)
  end
end.parse!

