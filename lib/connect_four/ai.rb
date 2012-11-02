
class AI < Player

  attr_accessor :board

  def initialize(name, email, wins = 0, losses = 0, draws = 0)
    super(name, email, wins, losses, draws)
    @best_move = []
  end

  def best_move
    check_columns
    # check row
    # check diag
    @best_move[0]
  end


  def move(board)
    @board = board
    return best_move
  end

  def opponent_token
    @board.get_value_at(@board.current_column, @board.current_row)
  end

  def check_columns
    three_in_row = ["#{opponent_token}", "#{opponent_token}", "#{opponent_token}"]
    @board.columns.each_with_index do |column, index| #get column values not object
      column_best_move = index + 1 if column.each_cons(3).any? { |three| three == three_in_row }
    end
    @best_move << column_best_move
  end
end