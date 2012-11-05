require_relative 'connect_four/board'
require_relative 'connect_four/column'
require_relative 'connect_four/player'
require_relative 'connect_four/game'
require_relative 'connect_four/ai'
require_relative 'connect_four/twitter'
require 'sqlite3'


bot = Connect4Twitter.new
bot.start_game


# game = Game.new
# game.start!
