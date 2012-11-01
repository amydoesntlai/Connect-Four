require_relative 'spec_helper'

describe Board do
  let(:board)  { Board.new }
  let(:column) { Column.new }
  context "#initialize" do
    it "has 7 columns" do
      board.columns.length.should eq(7)
    end

    it "contains Column objects" do
      board.columns[0].should be_an_instance_of(Column)
    end

    it "initializes game_over as false" do
      board.game_over.should be false
    end
  end

  context "#insert" do
    it "inserts token into the Column object" do
      board.columns[1].should_receive(:insert).with(:black).and_return(1)
      board.insert(1, :black)
    end
  end

  context "#get_value_at" do
    it "checks value of a row in a column" do
      board.columns[1].stub(:get_value_at).and_return(:black)
      board.get_value_at(1, 2).should == :black
    end
  end

  context "#column_values" do
    it "returns all column values" do
      board.insert(2, :black)
      board.columns[2].stub(:get_value_at).and_return(:black)
      board.column_values.should == [:black, :black, :black, :black, :black, :black]
    end
  end

  context "#row_values" do
    it "returns all row values" do
      board.insert(2, :red)
      0.upto(6) { |i| board.columns[i].stub(:get_value_at).and_return(:red) }
      board.row_values.should == [:red, :red, :red, :red, :red, :red, :red]
    end
  end

  context "#winner" do
    it "should change game_over to true" do
      expect { board.winner }.to change{ board.game_over }.from(false).to(true)
    end

    it "should change game_over to true if it calls row win"

    it "should change game_over to true if it calls column win"
      # expect { board.column_win }.to change{ board.game_over }.from(false).to(true)

    it "should change game_over to true if it calls diagonal win"
  end

  context "#connect_four?" do
    it "is true when passed four consecutive reds" do
      array = [:red, :red, :red, :red]
      board.connect_four?(array).should be_true
    end

    it "is false when passed alternating reds and blacks" do
      array = [:red, :black, :red, :black, :red]
      board.connect_four?(array).should be_false
    end

    it "is false when passed with four reds with an empty space in between" do
      array = [:red, :red, 0, :red, :red]
      board.connect_four?(array).should be_false
    end

  end

  context "#win?" do
    it "returns true when there is a connect four on a column" do
      board.insert(0, :black)
      board.columns[0].stub(:get_value_at).and_return(:black)
      board.win?.should be_true
    end

    it "returns true when there is a connect four on a row" do
      board.insert(0, :red)
      0.upto(6) { |i| board.columns[i].stub(:get_value_at).and_return(:red) }
      board.win?.should be_true
    end

    it "returns true when there is a connect four on a diagonal"

    it "returns false when there is a draw" do
      0.upto(2) do |column|
        3.times { board.insert(column, :red) }
        3.times { board.insert(column, :black) }
      end
      3.upto(5) do |column|
        3.times { board.insert(column, :black) }
        3.times { board.insert(column, :red) }
      end
      3.times { board.insert(6, :red) }
      3.times { board.insert(6, :black) }
      board.win?.should be_false
    end

    it "returns false when the game is not finished" do
      0.upto(2) do |column|
        3.times { board.insert(column, :red) }
        3.times { board.insert(column, :black) }
      end
      board.win?.should be_false
    end

  end

  context "#full?" do
    it "returns true when the board is full" do
      0.upto(6) { |column| 6.times { board.insert(column, :red) } }
      board.full?.should be_true
    end

    it "returns false when there are still empty spaces" do
      0.upto(6) { |column| 5.times { board.insert(column, :red) } }
      board.insert(4, :red)
      board.full?.should be_false
    end
  end

end
