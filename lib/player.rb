require 'sqlite3'

class Player

  attr_reader :name, :email, :wins, :losses, :draws

  def initialize(name, email)
    @name = name
    @email = email
    @wins = 0
    @losses = 0
    @draws = 0
  end

  def save
    db = SQLite3::Database.new("player.db")
    db.execute("CREATE TABLE IF NOT EXISTS players (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name varchar, email varchar UNIQUE, wins integer, losses integer, draws integer, created_at datetime)")
    db.execute("INSERT INTO players (name, email, wins, losses, draws, created_at) VALUES ( ?, ?, ?, ?, ?, DATETIME('now') )", @name, @email, @wins, @losses, @draws)
  end

end