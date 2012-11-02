require_relative '../connect_four'

class Game
  def initialize
    @board = Board.new
    @players = []
    @tokens = ['X', 'O']
  end

  def start!
    puts "Please enter name if you are human or enter CPU to play AI"
    @player1 = gets.chomp
    puts "Please enter name if you are human or enter CPU to play AI"
    @player2 = gets.chomp
    get_players
    @board.to_s
    begin
      puts "Please enter move #{current_player.name}: #{current_token}"
      if @board.insert(current_player.move, current_token)
        toggle_player
      else
        puts "invalid move, try again!!!!"
      end
      @board.to_s
    end until over?
    puts tie if @board.full?
    puts winner if @board.win?
  end

  def over?
    @board.win? || @board.full?
  end

  private
  attr_accessor :board, :players

  def current_player
    @players.first
  end

  def tie
    "Tie! SUDDEN DEATH!"
  end

  def winner
    toggle_player
    "winner is #{current_player.name}: #{current_token}"
  end

  def toggle_player
    @players << @players.shift
    @tokens << @tokens.shift
  end

  def current_token
    @tokens.first
  end

  def get_players
    @player1 =~ /cpu/i ? @players <<  AI.new("#{@player1}", "p1@dbc.com") : @players <<  Human.new("#{@player1}", "p1@dbc.com")
    @player2 =~ /cpu/i ? @players <<  AI.new("#{@player2}", "p2@dbc.com") : @players <<  Human.new("#{@player2}", "p2@dbc.com")
  end
end
