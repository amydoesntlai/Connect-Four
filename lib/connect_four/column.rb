class Column

  attr_reader :number_of_pieces

  def initialize
    @number_of_pieces = 0
    @values = Array.new(6, ".")
  end

  def get_value_at(position)
    @values[position]
  end

  def insert(item) #drop piece/chip
    return nil if @number_of_pieces == 6
    # raise("Column is full!") if @number_of_pieces == 6
    @values[@number_of_pieces] = item
    @number_of_pieces += 1
  end

  def full?
    @number_of_pieces == 6
  end

end
