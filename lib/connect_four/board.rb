class Board
  attr_reader :columns
  def initialize
    @columns = Array.new(7) { Column.new }
  end

  def get_value_at(column_num, row)
    @columns[column_num].get_value_at(row)
  end

  def insert(column_num, token)
    @current_row = @columns[column_num].insert(token) - 1
    @current_column = column_num
  end

  def column_values
    column_values = []
    0.upto(5) { |row| column_values << @columns[@current_column].get_value_at(row) }
    column_values
  end

  def row_values
    row_values = []
    0.upto(6) { |column_num| row_values << @columns[column_num].get_value_at(@current_row) }
    row_values
  end

  def positive_diagonal_values
    diagonal_values = []
    row_num = 0
    column_num = 0
    row_num = @current_row - @current_column if @current_row > @current_column
    column_num = @current_column - @current_row if @current_column > @current_row
    while column_num < 7 && row_num < 6
      diagonal_values << @columns[column_num].get_value_at(row_num)
      column_num += 1
      row_num += 1
    end
    diagonal_values
  end

  def negative_diagonal_values
    diagonal_values = []
    sum = @current_row + @current_column
    if sum <= 6
      column_num = sum
      row_num = 0
    else
      column_num = 6
      row_num = sum - 6
    end
    while row_num < 6
      diagonal_values << @columns[column_num].get_value_at(row_num)
      column_num -= 1
      row_num += 1
    end
    diagonal_values
  end

  def connect_four?(values)
    o_win = ["O", "O", "O", "O"]
    x_win = ["X", "X", "X", "X"]
    values.each_cons(4).any? { |four| four == o_win || four == x_win }
  end

  def win?
    connect_four?(column_values) || connect_four?(row_values) || connect_four?(positive_diagonal_values) || connect_four?(negative_diagonal_values)
  end

  def full?
    row_values.all? { |value| value != " " } && @current_row == 5
  end

  def to_s
    5.downto(0) do |row_num|
      row_values = []
      0.upto(6) { |column_num| row_values << @columns[column_num].get_value_at(row_num) }
      puts row_values.join(' | ')
    end
    return
  end
end