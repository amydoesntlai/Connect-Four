require_relative '../connect_four'

class Game

  def initialize
    @board = Board.new
    @players = [ Player.new("bill", "bill@bronsky.com"), Player.new("sam", "sam@sam.com") ]
    @tokens = ['X', 'O']
  end

  def start!
    get_players
    begin
      if @board.insert(current_player.human_move, current_token)
        toggle_player
      else
        puts "invalid move, try again!!!!"
      end
      @board.to_s
    end while !over?
    toggle_player
    puts "winner is #{current_player.name} with #{current_token}"
  end

  def over?
    @board.full? || @board.win?
  end

  private
  attr_accessor :board, :players

  def current_player
    @players.first
  end

  def toggle_player
    @players << @players.shift
    @tokens << @tokens.shift
  end

  def current_token
    @tokens.first
  end

  def get_players
    @players[0] = Player.new("p1", "p1@dbc.com")
    @players[1] = Player.new("p2", "p2@dbc.com")

    # if name == cpu, use ai for player
  end


end

game = Game.new
game.start!



# open a new game
# get 2 players
  # while player count is less <= 2
    # player enters name and email
      # save player to db
        # if they exist, update player with existing stats
        # else insert new player into db

# start game
  # while game is not over
    # game prints board
    # ask player where to move
      # player enters column
      # game places piece
      # game checks for winner
      # game switches to next player

  # if game over and not a draw
    # increment winning player win count
    # increment losing player lose count
  # if game over and a draw
    # increment both players draw count

  # play again?
# quit game or restart game?

