class Player

  attr_accessor :name, :email, :wins, :losses, :draws

  def initialize(name, email, wins = 0, losses = 0, draws = 0)
    @name = name
    @email = email
    @wins = wins
    @losses = losses
    @draws = draws
  end

  def save_to_db(db)
    # db = SQLite3::Database.new("player.db")
    db.execute("CREATE TABLE IF NOT EXISTS players (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name varchar, email varchar UNIQUE, wins integer, losses integer, draws integer, created_at datetime)")
    db.execute("INSERT INTO players (name, email, wins, losses, draws, created_at) VALUES ( ?, ?, ?, ?, ?, DATETIME('now') )", @name, @email, @wins, @losses, @draws)
  end

  def retrieve_from_db(db)
    db.execute("SELECT name, email, wins, losses, draws FROM players WHERE name = ?", @name)
  end

  def load_from_db(db)
    player_info = retrieve_from_db(db).flatten
    new_player = Human.new(player_info[0], player_info[1], player_info[2], player_info[3], player_info[4])
  end

  def update_db(db)#, name, email, wins, losses, draws)
    db.execute("UPDATE players SET wins = ?, losses = ?, draws = ? WHERE name = ?", @wins, @losses, @draws, @name)
    self
  end

  def move
    raise ("This method must be initialized by a subclass.")
  end

  def win_game
    @wins += 1
  end

  def lose_game
    @losses += 1
  end

  def draw_game
    @draws += 1
  end
end


class Human < Player
  def move
    next_move = gets.chomp.to_i
    if next_move > 7 || next_move < 1
      puts "invalid move, try again!?!?"
      next_move = move
    end
    next_move
  end
end

class AI < Player
  def move
    rand(7) + 1
  end
end
# player.update_db(players.db, 'Fred')