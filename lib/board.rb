require_relative './column.rb'

class Board
  attr_reader :columns, :game_over, :insert, :last_row_played
  def initialize
    @columns   = Array.new(7) { Column.new }
    @game_over = false
  end

  def get_value_at(column_num, row)
    @columns[column_num].get_value_at(row)
  end

  def insert(column_num, token)
    @last_row_played = @columns[column_num].insert(token) - 1
    @last_column_played = column_num
  end

  def column_values
    column_values = []
    0.upto(5) { |row| column_values << @columns[@last_column_played].get_value_at(row) }
    column_values
  end

  def row_values
    row_values = []
    0.upto(6) { |column_num| row_values << @columns[column_num].get_value_at(@last_row_played) }
    row_values
  end

  def winner
    @game_over = true
  end

  def connect_four?(values)
    red_win = [:red, :red, :red, :red]
    black_win = [:black , :black, :black, :black]
    values.each_cons(4).any? { |four| four == red_win || four == black_win }
  end

  def win?
    connect_four?(column_values) || connect_four?(row_values) # || connect_four(diagonal_values)
  end

  def full?
    row_values.all? { |value| value != 0 } && @last_row_played == 5
  end

end