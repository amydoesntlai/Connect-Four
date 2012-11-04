require 'Twitter'
require 'tweetstream'
require_relative '../connect_four'

class Connect4Twitter

  def initialize
    @bot_name = "Connect4twenty"
  end

  Twitter.configure do |config|
    config.consumer_key = 'TxU3XG4rnX0MbY2bbVZJg'
    config.consumer_secret = 'l69Ov7Ueh15rmqghCm6jyLSbzPniopXbgF8CVuIpLLM'
    config.oauth_token = '922480028-F7tCuIJqUp0LdL6EeJEqiCZ4dsY89U7qlKepDuzx'
    config.oauth_token_secret = 'ydXvCrlXy9dbLaIuuaswc3uFHHLMRRXfQ5JFqBd7qfA'
  end

  TweetStream.configure do |config|
    config.consumer_key = 'TxU3XG4rnX0MbY2bbVZJg'
    config.consumer_secret = 'l69Ov7Ueh15rmqghCm6jyLSbzPniopXbgF8CVuIpLLM'
    config.oauth_token = '922480028-F7tCuIJqUp0LdL6EeJEqiCZ4dsY89U7qlKepDuzx'
    config.oauth_token_secret = 'ydXvCrlXy9dbLaIuuaswc3uFHHLMRRXfQ5JFqBd7qfA'
    config.auth_method = :oauth
  end

  @client_connected4 = Twitter::Client.new(
    :oauth_token => '922480028-F7tCuIJqUp0LdL6EeJEqiCZ4dsY89U7qlKepDuzx',
    :oauth_token_secret => 'ydXvCrlXy9dbLaIuuaswc3uFHHLMRRXfQ5JFqBd7qfA'
    )

  def send_challenge
    hashstr = ('a'..'z').to_a.shuffle[0..2].join
    Twitter.update("Who wants to get demolished? #dbc_c4 ##{hashstr}")
  end

  def accept_challenge(responder)
    hashstr = ('a'..'z').to_a.shuffle[0..2].join
    Twitter.update("@#{responder} Game on! #dbc_c4 ##{hashstr}")
  end

  def play_game
    TweetStream::Client.new.userstream do |tweet|
      name = tweet.user[:screen_name]
      unless tweet.text.include?("I win! Good game.") || tweet.text.include?("Draw game. Play again?")
        if name != "#{@bot_name}" && tweet.text.include?("@#{@bot_name}")
          twitter_board = tweet.text.split(' ')[1]
          board = Board.from_string(twitter_board)
          twitter_board.scan(/X/i).length == twitter_board.scan(/O/i).length ? piece = "X" : piece = "O"
          board.insert((rand(7) + 1), piece)
          hashstr = ('a'..'z').to_a.shuffle[0..2].join
          Twitter.update("@#{tweet.user[:screen_name]} #{board.to_twitter} #dbc_c4 ##{hashstr}")
        end
        send_challenge if tweet.text.include?("I win! Good game.") || tweet.text.include?("Draw game. Play again?") #not tested
      end
    end
  end

  def start_game
    send_challenge #sends initial challenge
    TweetStream::Client.new.userstream do |tweet|
      name = tweet.user[:screen_name]
      if tweet.text.include?("@#{@bot_name} Game on!")
        board = Board.from_string("|.......|.......|.......|.......|.......|.......|")
        board.insert((rand(7) + 1), "X")
        hashstr = ('a'..'z').to_a.shuffle[0..2].join
        Twitter.update("@#{tweet.user[:screen_name]} #{board.to_twitter} #dbc_c4 ##{hashstr}")
        play_game
      elsif tweet.text.include?("Who wants to get demolished? #dbc_c4") && name != "#{@bot_name}"
        accept_challenge(tweet.from_user)
      else
        play_game
      end
    end
  end
end

bot = Connect4Twitter.new
bot.start_game
