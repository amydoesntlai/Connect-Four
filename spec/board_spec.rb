require_relative '../lib/board.rb'

describe Board do
  let(:board)  { Board.new }
  let(:column) { Column.new }
  context "#initialize" do
    it "should have 7 columns" do
      board.columns.length.should eq(7)
    end

    it "should contain Column objects" do
      board.columns[0].should be_an_instance_of(Column)
    end

    it "should initialize game_over as false" do
      board.game_over.should be false
    end
  end

  context "#insert" do
    it "should insert token into the Column object" do
      board.columns[1].should_receive(:insert).with('Black')
      board.insert(1, 'Black')
    end
  end

  context "#get_value_at" do
    it "should check y value of a row in a column" do
      board.columns[1].should_receive(:get_value_at).with(2)
      board.get_value_at(1, 2)
    end
  end

  context "#column_values" do
    it "should return all column values" do
      board.columns[2].should_receive(:get_value_at).exactly(6).times
      board.column_values(2)
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

  context "column_win?" do
    it "should return true if it has 4 of the same pieces in the same column" do
      board.columns[2].should_receive(:get_value_at).exactly(6).times.and_return(:black)
      board.column_win?(2).should be_true
    end
  end


end
