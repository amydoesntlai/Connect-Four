class Board
  attr_reader :columns, :current_row, :current_column
  def initialize
    @columns = Array.new(7) { Column.new }
  end

  def get_value_at(column_num, row)
    @columns[column_num].get_value_at(row)
  end

  def insert(column_num, token)
    return if @columns[column_num - 1].number_of_pieces == 6
    @columns[column_num - 1].insert(token)
  end

  def column_values(column_num)
    column_values = []
    0.upto(5) { |row| column_values << @columns[column_num].get_value_at(row) }
    column_values
  end

  def row_values(row_num)
    row_values = []
    0.upto(6) { |column_num| row_values << @columns[column_num].get_value_at(row_num) }
    row_values
  end

  def positive_diagonal_values(column_num)
    #this method checks diagonals for the column_num at row with index 2 (0-based)
    diagonal_values = []
    if column_num <= 2
      iterating_row = 2 - column_num
      iterating_column = 0
    else
      iterating_row = 0
      iterating_column = column_num - 2
    end
    while iterating_column < 7 && iterating_row < 6
      diagonal_values << @columns[iterating_column].get_value_at(iterating_row)
      iterating_column += 1
      iterating_row += 1
    end
    diagonal_values
  end

  def negative_diagonal_values(column_num)
    #this method checks diagonals for the column_num at row with index 2 (0-based)
    diagonal_values = []
    if column_num > 4
      iterating_row = 6 - column_num
      iterating_column = 6
    else
      iterating_row = 0
      iterating_column = column_num + 2
    end
    while iterating_row < 6
      diagonal_values << @columns[iterating_column].get_value_at(iterating_row)
      iterating_column -= 1
      iterating_row += 1
    end
    diagonal_values
  end

  def connect_four?(values)
    o_win = ["O", "O", "O", "O"]
    x_win = ["X", "X", "X", "X"]
    values.each_cons(4).any? { |four| four == o_win || four == x_win }
  end

  def win?
    0.upto(6) do |column_num|
      return true if connect_four?(column_values(column_num)) || connect_four?(positive_diagonal_values(column_num)) || connect_four?(negative_diagonal_values(column_num))
    end
    0.upto(5) do |row_num|
      return true if connect_four?(row_values(row_num))
    end
    false
  end

  def full?
    row_values(5).all? { |value| value != "." }
  end

  def to_s
    5.downto(0) do |row_num|
      row_values = []
      0.upto(6) { |column_num| row_values << @columns[column_num].get_value_at(row_num) }
      puts row_values.join(' | ')
    end
    puts "-" * 25 + "\n1 | 2 | 3 | 4 | 5 | 6 | 7"
    return
  end

  def to_twitter
    twitter_board = ""
    5.downto(0) do |row_num|
      row_values = []
      0.upto(6) { |column_num| row_values << @columns[column_num].get_value_at(row_num) }
      twitter_board += "|" + row_values.join
    end
    twitter_board += "|"
    return twitter_board
  end

  def self.from_string(twitter_board)
    board = Board.new
    c4_array = twitter_board.gsub("|", "").split(//).each_slice(7).to_a.reverse
    c4_array.each do |row|
      row.each_with_index { |token, index| board.insert(index + 1, token) if token == 'X' || token == 'O' }
    end
    board
  end
end
