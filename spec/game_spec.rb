require 'spec_helper'

describe Game do
  let(:game) { Game.new }
  let(:mock_player1) { mock("Player", :name => 'bill', :move => 4) }
  let(:mock_player2) { mock("Player", :name => 'sam', :move => 5) }
  describe '#start!' do

    before :each do
      Human.stub(:new).and_return(mock_player1, mock_player2)
      game.stub(:over?).exactly(3).times.and_return(false, false, true)
    end

    it "gets the players" do
      game.should_receive(:get_players)
      game.start!
    end

    context "while the game is not over" do
      it "loops" do
        game.should_receive(:over?).exactly(3).times.and_return(false, false, true)
        game.start!
        game.should_receive(:over?).exactly(2).times.and_return(false, true)
        game.start!
      end

      context "when the current player makes a valid move" do
        it "toggles players" do
          mock_player1.should_receive(:move).once.and_return(4)
          mock_player2.should_receive(:move).once.and_return(4)
          game.start!
        end
      end

      context "when the current player makes an invalid move" do
        it "toggles players" do
          Board.any_instance.stub(:insert).and_return(false, true)
          mock_player1.should_receive(:move).twice.and_return(4)
          mock_player2.should_not_receive(:move)
          game.start!
        end
      end

    end
  end

  describe '#over?' do
    context "when the board has a connect four" do
      it "returns true" do
        Board.any_instance.stub(:full?).and_return(false)
        Board.any_instance.stub(:win?).and_return(true)
        game.should be_over
      end
    end

    context "when the board is full" do
      it "returns true" do
        Board.any_instance.stub(:full?).and_return(true)
        Board.any_instance.stub(:win?).and_return(false)
        game.should be_over
      end
    end

    context "when neither connect four or full board" do
      it "returns false" do
        Board.any_instance.stub(:full?).and_return(false)
        Board.any_instance.stub(:win?).and_return(false)
        game.should_not be_over
      end
    end
  end
end