require_relative 'connect_four/board'
require_relative 'connect_four/column'
require_relative 'connect_four/player'
require_relative 'connect_four/game'
require 'sqlite3'

game = Game.new
game.start!
