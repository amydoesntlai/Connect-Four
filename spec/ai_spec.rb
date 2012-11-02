require_relative 'spec_helper'

describe AI do
  let(:ai) { AI.new("AI", "ai@dbc.com") }
  let(:board) { mock 'Board' }

#check columns



  describe 'checking for player 3 in a row in a column' do
    context '#check_column' do
      it 'selects the column where the player has 3 in a row in a column and an empty space above' do
        board = Board.new
        3.times { board.insert(4,'X') }
        # ai.stub(:move).with(board)
        # board.stub(:current_column).and_return(4)
        # board.stub(:current_row).and_return(3)
        ai.move(board).should eq 4
        # ai.check_columns.should eq 5
      end

      it 'does not select a column where the player had 3 in a row in a column and no empty space above' do

      end
    end
  end



end
