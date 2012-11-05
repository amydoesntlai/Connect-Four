
class AI < Player

  attr_accessor :board

  def initialize(name, email, wins = 0, losses = 0, draws = 0)
    super(name, email, wins, losses, draws)
    # @best_move = [4, 5, 3, 6, 2, 7, 1]
    @best_move = []
  end

  def best_move
    return check_columns(@token) unless check_columns(@token) == nil
    return check_rows(@token) unless check_rows(@token) == nil
    return check_positive_diagonals(@token) unless check_positive_diagonals(@token) == nil
    return check_negative_diagonals(@token) unless check_negative_diagonals(@token) == nil
    # puts "block"
    return check_columns(@opp_token) unless check_columns(@opp_token) == nil
    return check_rows(@opp_token) unless check_rows(@opp_token) == nil
    return check_positive_diagonals(@opp_token) unless check_positive_diagonals(@opp_token) == nil
    return check_negative_diagonals(@opp_token) unless check_negative_diagonals(@opp_token) == nil
    # puts "random"
    # @best_move[0]
    rand(7)
  end

  def move(board, token)
    @board = board
    @token = token
    @opp_token = @token == 'X' ? 'O' : 'X'
    return best_move + 1
  end

  def check_columns(token)
    @board.column_close_to_win(token)
  end

  def check_rows(token)
    0.upto(5) do |row|
      col_num_array = @board.close_to_win(@board.row_values(row), token)
      col_num_array.each do |col_num|
      # puts "row #{row} col_num #{col_num}"
        return col_num if (col_num != nil && @board.columns[col_num].number_of_pieces == row)
      end
    end
    nil
  end

  def check_positive_diagonals(token)
    0.upto(6) do |column|
      open_index_array = @board.close_to_win(@board.positive_diagonal_values(column), token)
      open_index_array.each do |open_index|
        return column - 2 + open_index if (open_index != nil && @board.columns[column - 2 + open_index].number_of_pieces == open_index)
        # @best_move.delete(column - 2 + open_index if (open_index != nil && @board.columns[column - 2 + open_index].number_of_pieces - 1 == open_index))
      end
    end
    nil
  end

  def check_negative_diagonals(token)
    0.upto(6) do |column|
      # if column < 3

      open_index_array = @board.close_to_win(@board.negative_diagonal_values(column), token)
      open_index_array.each do |open_index|
      # if open_index != nil
      #   puts "column to insert into: #{column - 2 + open_index}"
      #   puts @board.columns[column - 3 + open_index].number_of_pieces
      #   puts "open_index: #{open_index}"
      # end
        return column - 3 + open_index if (open_index != nil && @board.columns[column - 3 + open_index].number_of_pieces == 5 - open_index)
      end
    end
    nil
  end
end