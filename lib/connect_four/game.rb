require_relative '../connect_four'

class Game
  def initialize
    @board = Board.new
    @players = []
    @tokens = ['X', 'O']
    @db = SQLite3::Database.new("player.db")
  end

  def start!
    puts "Please enter name if you are human or enter CPU to play AI"
    @player1 = gets.chomp
    unless @player1 =~ /cpu/i
      puts "Please enter email"
      @player1_email = gets.chomp
    end

    puts "Please enter name if you are human or enter CPU to play AI"
    @player2 = gets.chomp
    unless @player2 =~ /cpu/i
      puts "Please enter email"
      @player2_email = gets.chomp
    end

    get_players
    puts "\nConnected Four presents Connect 4!!!\n\n"
    # @board.to_s
    begin
      if @board.insert(current_player.move(@board), current_token)
        toggle_player
      else
        puts "invalid move, try again!!!!"
      end
      # @board.to_s
    end until over?
    puts tie if @board.full?
    winner if @board.win?
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
    @players.each { |player| player.draw_game }
    @players.each { |player| player.update_db(@db) }
    "Tie! SUDDEN DEATH!"
  end

  def winner
    current_player.lose_game
    loser = "#{current_player.name}'s record is #{current_player.wins}-#{current_player.losses}-#{current_player.draws}"
    toggle_player
    current_player.win_game
    winner = "#{current_player.name}'s record is #{current_player.wins}-#{current_player.losses}-#{current_player.draws}"
    @players.each { |player| player.update_db(@db) }
    result = "winner is #{current_player.name}: #{current_token}"
    game_summary(result, winner, loser)
  end

  def game_summary(result, winner, loser)
    puts result
    puts winner
    puts loser
  end

  def toggle_player
    @players << @players.shift
    @tokens << @tokens.shift
  end

  def current_token
    @tokens.first
  end

  def get_players
    if @player1 =~ /cpu/i
      @players <<  AI.new("#{@player1}", "AI@dbc.com")
    else
      new_player1 = Human.new("#{@player1}", "#{@player1_email}")
      new_player1.save_to_db(@db)
      new_player1 = new_player1.load_from_db(@db)
      @players <<  new_player1
    end

    if @player2 =~ /cpu/i
      @players <<  AI.new("#{@player1}", "AI@dbc.com")
    else
      new_player2 = Human.new("#{@player2}", "#{@player2_email}")
      new_player2.save_to_db(@db)
      new_player2 = new_player2.load_from_db(@db)
      @players <<  new_player2
    end

  end
end
