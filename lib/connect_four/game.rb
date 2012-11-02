class Game

  def initialize
    self.board = Board.new
    self.players = [ Player.new("bill", "bill@bronsky.com"), Player.new("sam", "sam@sam.com") ]
  end

  def start!
    get_players
    while !over?
      if board.insert(current_player.move, current_player.name)
        toggle_player
      else
        "invalid move"
      end
    end
  end

  def over?
    board.full? || board.win?
  end

  private
  attr_accessor :board, :players

  def current_player
    @players.first
  end

  def toggle_player
    @players << @players.shift
  end

  def get_players
  end

end