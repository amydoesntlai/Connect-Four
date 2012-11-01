# require './column.rb'

class Board
  attr_reader :columns, :game_over, :insert
  def initialize
    @columns   = Array.new(7) { Column.new }
    @game_over = false
  end

  def get_value_at(column, y)
    @columns[column].get_value_at(y)
  end

  def insert(column, token)
    @columns[column].insert(token)
  end

  def column_values(column, row = 0)
    @column_values = []
    6.times do
      @column_values << @columns[column].get_value_at(row)
      row += 1
    end
    @column_values
  end

  def winner
    @game_over = true
  end

  def column_win?(column)
    column_values(column)
    red_win = [:red, :red, :red, :red]
    black_win = [:black , :black, :black, :black]
    @column_values.each_cons(4) { |four| return true if four == red_win || four == black_win }
    false
  end


end

class Column
  attr_accessor :get_value_at
end