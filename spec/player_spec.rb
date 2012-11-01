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

  context '#save_to_db' do

    before(:each) do
      @db = SQLite3::Database.new("player.db")
    end

    after(:each) do
      @db.execute("delete from players where email = 'gene@email.com'")
    end

    it 'does not add a player who already exists' do
      @player.save_to_db
      expect { @player.save }.to raise_error
    end

    it "saves the post to a database" do
      @player.save_to_db
      @db.execute("select name from players where email = 'gene@email.com'").should == [['Gene']]
    end

  end

  # context '#play' do
  #
  # end

  context '#retrieve_from_db' do

    before(:each) do
      @db = SQLite3::Database.new("player.db")
    end

    after(:each) do
      @db.execute("delete from players where email = 'gene@email.com'")
    end

    it 'gets all info from database for player matching given player name' do
      #search database
      #if database.name == name, return player.info
      @player.save_to_db
      @player.retrieve_from_db(@db).should == [['Gene', 'gene@email.com', 0, 0, 0]]
    end

  end

  context '#load_from_db' do

    before(:each) do
      @db = SQLite3::Database.new("player.db")
    end

    after(:each) do
      @db.execute("delete from players where email = 'gene@email.com'")
    end

    it 'returns a new player with the given info from the database' do
      @player.save_to_db
      # info = @player.retrieve_from_db(@db).flatten
      @player.load_from_db(@db).name.should == 'Gene'
      @player.load_from_db(@db).wins.should == 0
    end
  end

  context '#update_db' do

    before(:each) do
      @db = SQLite3::Database.new("player.db")
    end

    after(:each) do
      @db.execute("delete from players where email = 'gene@email.com'")
    end

    it 'updates the information of a given player' do
      # check player wins from db
      # update player wins and load to db
      # laod player from db again and check to make sure it was updated
      @player.save_to_db
      # @player.wins.should == 0
      @player.wins += 1
      # expect { @player.update_db(@db) }.to change { @player.wins }.from(0).to(1)
      @player.update_db(@db)
      @player.load_from_db(@db).wins.should == 1
    end
  end

  context '#win' do
    it 'increments the player win total by 1'

  end

  context '#lose' do
    it 'increments the player losses total by 1'

  end

  context '#draw' do
    it 'inrements the player draws total by 1'

  end
end


# create player and check if they exist in db
# if they exist pull his data and store in an object
# else insert new player in db

# play the game

# keep in memory until completing the game
# update wins/losses in db