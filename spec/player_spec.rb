require 'sqlite3'
require_relative '../lib/player'

describe Player do

  before(:each) do
    @player = Player.new("Gene", "gene@email.com")
  end

  context '#initialize' do
    it "starts with 0 wins, 0 losses, and 0 draws" do
      @player.wins.should == 0
      @player.losses.should == 0
      @player.draws.should == 0
    end
  end

  context '#save' do

    before(:each) do
      @db = SQLite3::Database.new("player.db")
    end

    after(:each) do
      @db.execute("delete from players where email = 'gene@email.com'")
    end

    it 'does not add a player who already exists' do
      @player.save
      expect { @player.save }.to raise_error
    end

    it "saves the post to a database" do
      @player.save
      @db.execute("select name from players where email = 'gene@email.com'").should == [['Gene']]
    end

  end

  context '#play' do

  end

  context '#retrieve_from_db' do

  end

  # context '#update_db' do
  #
  # end

end


# create player and check if they exist in db
# if they exist pull his data and store in an object
# else insert new player in db

# play the game

# keep in memory until exiting the game
# update wins/losses in db