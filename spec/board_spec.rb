require_relative 'spec_helper'

describe Board do
  let(:board)  { Board.new }
  context "#initialize" do
    it "contains Column objects" do
      board.columns[0].should be_an_instance_of(Column)
    end
  end

  context "#insert" do
    it "inserts token into the Column object" do
      board.columns[0].should_receive(:insert).with("X").and_return(1)
      board.insert(1, "X")
    end
  end

  context "#get_value_at" do
    it "checks value of a row in a column" do
      board.columns[1].stub(:get_value_at).and_return("X")
      board.get_value_at(1, 2).should eq "X"
    end
  end

  context "#column_values" do
    it "returns all column values" do
      board.insert(2, "X")
      board.columns[1].stub(:get_value_at).and_return("X")
      board.column_values(1).should eq ["X", "X", "X", "X", "X", "X"]
    end
  end

  context "#row_values" do
    it "returns all row values" do
      board.insert(2, "O")
      0.upto(6) { |i| board.columns[i].stub(:get_value_at).and_return("O") }
      board.row_values(1).should eq ["O", "O", "O", "O", "O", "O", "O"]
    end
  end

  context "#diagonal_values" do
    it "returns positive slope diagonal values" do
      board.insert(4, "O")
      board.positive_diagonal_values(5).should eq ["O", ".", ".", "."]
      3.times { board.insert(5, "O") }
      board.positive_diagonal_values(4).should eq [".", ".", "O", ".", "."]
    end
  end

  context "#connect_four?" do
    it "is true when passed four consecutive o's" do
      array = ["O", "O", "O", "O"]
      board.connect_four?(array).should be_true
    end

    it "is false when passed alternating o's and x's" do
      array = ["O", "X", "O", "X", "O"]
      board.connect_four?(array).should be_false
    end

    it "is false when passed with four o's with an empty space in between" do
      array = ["O", "O", ".", "O", "O"]
      board.connect_four?(array).should be_false
    end

  end

  context "#win?" do
    it "returns true when there is a connect four on a column" do
      board.insert(1, "X")
      board.columns[0].stub(:get_value_at).and_return("X")
      board.win?.should be_true
    end

    it "returns true when there is a connect four on a row" do
      board.insert(1, "O")
      0.upto(6) { |i| board.columns[i].stub(:get_value_at).and_return("O") }
      board.win?.should be_true
    end

    it "returns true when there is a connect four on a positive slope diagonal starting column index 0" do
      board.insert(1, "O")
      board.insert(2, "X")
      board.insert(2, "O")
      2.times { board.insert(3, "X") }
      board.insert(3, "O")
      3.times { board.insert(4, "X") }
      board.insert(4, "O")
      board.win?.should be_true
    end

    it "returns true when there is a connect four on a positive slope diagonal starting column index 3" do
      board.insert(4, "O")
      board.insert(5, "X")
      board.insert(5, "O")
      2.times { board.insert(6, "X") }
      board.insert(6, "O")
      3.times { board.insert(7, "X") }
      board.insert(7, "O")
      board.win?.should be_true
    end

    it "returns false when there is not a connect four on a positive slope diagonal" do
      board.insert(0, "O")
      board.insert(1, "X")
      board.insert(1, "X")
      2.times { board.insert(2, "X") }
      board.insert(2, "O")
      3.times { board.insert(3, "X") }
      board.insert(3, "O")
      board.win?.should be_false
    end

    it "returns true when there is a connect four on a (negative diagonal that begins on the bottom row)" do
      board.insert(6, "O")
      board.insert(5, "X")
      board.insert(5, "O")
      2.times { board.insert(4, "X") }
      board.insert(4, "O")
      3.times { board.insert(3, "X") }
      board.insert(3, "O")
      board.win?.should be_true
    end

    it "returns true when there is a connect four on a (negative diagonal that begins above the bottom row)" do
      6.downto(4) { |column| board.insert(column, "X") }
      board.insert(3, "O")
      5.downto(3) { |column| board.insert(column, "X") }
      4.downto(3) { |column| board.insert(column, "X") }
      board.insert(3, "O")
      6.downto(3) { |column| board.insert(column, "O") }
      board.win?.should be_true
    end

    it "indicates a full board with no win when there is a draw" do
      3.times { board.insert(1, "O") }
      3.times { board.insert(1, "X") }
      3.times { board.insert(2, "X") }
      3.times { board.insert(2, "O") }
      3.times { board.insert(3, "O") }
      3.times { board.insert(3, "X") }
      3.times { board.insert(4, "X") }
      3.times { board.insert(4, "O") }
      3.times { board.insert(5, "O") }
      3.times { board.insert(5, "X") }
      3.times { board.insert(6, "X") }
      3.times { board.insert(6, "O") }
      3.times { board.insert(7, "O") }
      3.times { board.insert(7, "X") }
      board.win?.should be_false
      board.full?.should be_true
    end

    it "returns false when the game is not finished" do
      0.upto(2) do |column|
        3.times { board.insert(column, "O") }
        3.times { board.insert(column, "X") }
      end
      board.win?.should be_false
    end

  end

  context "#full?" do
    it "returns true when the board is full" do
      0.upto(6) { |column| 6.times { board.insert(column, "O") } }
      board.full?.should be_true
    end

    it "returns false when there are still empty spaces" do
      0.upto(6) { |column| 5.times { board.insert(column, "O") } }
      board.insert(4, "O")
      board.full?.should be_false
    end
  end

  describe "win?" do
    before :each do
      board.stub(:column_values)
      board.stub(:get_value_at)
      board.stub(:row_values)
      board.stub(:positive_diagonal_values)
      board.stub(:negative_diagonal_values)
    end

    context "when there is a column connect four" do
      it "returns true" do
        board.stub(:connect_four?).and_return(true)
        board.should be_win
      end
    end

    context "when there is a row connect four" do
      it "returns true" do
        board.stub(:connect_four?).and_return(false, true)
        board.should be_win
      end
    end

    context "when there is a positive_diagonal connect four" do
      it "returns true" do
        board.stub(:connect_four?).and_return(false, false, true)
        board.should be_win
      end
    end

    context "when there is a negative_diagonal connect four" do
      it "returns true" do
        board.stub(:connect_four?).and_return(false, false, false, true)
        board.should be_win
      end
    end
  end

  describe '#close_to_win' do
    # (values, marker)
    it 'returns the column with 3 in a row' do
      2.upto(4) { |column| board.insert(column, "X") }
      board.close_to_win(board.row_values(0), "X").should eq 0
    end

    it "returns nil when no 3-in-a-row patterns are found" do
      board.insert(3, "X")
      board.insert(4, "O")
      board.insert(5, "X")
      board.insert(6, "X")
      board.close_to_win(board.row_values(0), "X").should be_nil
    end

    it "returns the column with 3 not in a row" do
      board.insert(3, "X")
      board.insert(4, ".")
      board.insert(5, "X")
      board.insert(6, "X")
      board.close_to_win(board.row_values(0), "X").should eq 3
    end
  end

  describe '#column_close_to_win' do
    it 'returns the column with 3 in a row and an empty space above' do
      3.times { board.insert(3, "X") }
      board.column_close_to_win('X').should eq 2
    end
    # (marker)

    it 'returns nil when there is 3 in a row in a column and filled with the opponent marker above' do
      3.times { board.insert(3, "X") }
      board.insert(3, "O")
      board.column_close_to_win('X').should be_nil
    end

    it 'returns nil when the column is full' do
      3.times { board.insert(3, "X") }
      3.times { board.insert(3, "O") }
      board.column_close_to_win("O").should be_nil
    end
  end
end
