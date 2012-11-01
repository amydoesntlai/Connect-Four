class Column

  def initialize
    @number_of_pieces = 0
    @values = Array.new(6, 0)
  end

  def get_value_at(position)
    @values[position]
  end

  def insert(item) #drop piece/chip
    raise("Column is full!") if @number_of_pieces == 6
    @values[@number_of_pieces] = item
    @number_of_pieces += 1
  end

end
