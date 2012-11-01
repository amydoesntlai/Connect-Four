class Player

  attr_accessor :name, :email, :wins, :losses, :draws

  def initialize(name, email, wins = 0, losses = 0, draws = 0)
    @name = name
    @email = email
    @wins = wins
    @losses = losses
    @draws = draws
  end

  def save_to_db
    db = SQLite3::Database.new("player.db")
    db.execute("CREATE TABLE IF NOT EXISTS players (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name varchar, email varchar UNIQUE, wins integer, losses integer, draws integer, created_at datetime)")
    db.execute("INSERT INTO players (name, email, wins, losses, draws, created_at) VALUES ( ?, ?, ?, ?, ?, DATETIME('now') )", @name, @email, @wins, @losses, @draws)
  end

  def retrieve_from_db(db)
    db.execute("SELECT name, email, wins, losses, draws FROM players WHERE name = ?", @name)
  end

  def load_from_db(db)
    player_info = retrieve_from_db(db).flatten
    new_player = Player.new(player_info[0], player_info[1], player_info[2], player_info[3], player_info[4])
  end

  def update_db(db)#, name, email, wins, losses, draws)
    db.execute("UPDATE players SET wins = ?, losses = ?, draws = ? WHERE name = ?", @wins, @losses, @draws, @name)
    self
  end

  def move
  end
end

# player.update_db(players.db, 'Fred')