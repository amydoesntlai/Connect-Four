require 'twitter'
require 'tweetstream'

class Connect4Twitter
  def start_game
    send_challenge
    TweetStream::Client.new.userstream do |tweet|
      name = tweet.user[:screen_name]
      if tweet.text.include?("@#{BOT_NAME}") && name != "#{BOT_NAME}"
        tweet.text.include?("Game on!") ? initial_start(tweet) : play_game(tweet)
      end
      accept_challenge(tweet) if tweet.text.include?("Who wants to get demolished? #dbc_c4") && name != "#{BOT_NAME}"
      send_challenge          if gameover?(tweet)
    end
  end

  private
  def initialize
    @ai = AI.new('AI', 'ai@example.com')
  end

  BOT_NAME = "connected_four"

  TWITTER_CONSUMER_KEY       = 'lYLogI01i8DFgko9yhV3Q'
  TWITTER_CONSUMER_SECRET    = 'cBfillLYNEoGEaDi1rq3xHqjzpCUrnG9fIbBblCimmQ'
  TWITTER_OAUTH_TOKEN        = '921647634-VUFL7tpgKXl17kzikMiEYI9SXIRcNphVAfhBD3Sb'
  TWITTER_OAUTH_TOKEN_SECRET = 'ABVlzHOARXh0ls8pOr9x9cLCUSz8YzvOOQZLdBaw0'

  Twitter.configure do |config|
    config.consumer_key       = TWITTER_CONSUMER_KEY
    config.consumer_secret    = TWITTER_CONSUMER_SECRET
    config.oauth_token        = TWITTER_OAUTH_TOKEN
    config.oauth_token_secret = TWITTER_OAUTH_TOKEN_SECRET
  end

  TweetStream.configure do |config|
    config.consumer_key       = TWITTER_CONSUMER_KEY
    config.consumer_secret    = TWITTER_CONSUMER_SECRET
    config.oauth_token        = TWITTER_OAUTH_TOKEN
    config.oauth_token_secret = TWITTER_OAUTH_TOKEN_SECRET
    config.auth_method        = :oauth
  end

  Twitter::Client.new(:oauth_token => TWITTER_OAUTH_TOKEN, :oauth_token_secret => TWITTER_OAUTH_TOKEN_SECRET)

  def shuffle_hashtag
    ('a'..'z').to_a.shuffle[0..2].join
  end

  def send_challenge
    Twitter.update("Who wants to get demolished? #dbc_c4 ##{shuffle_hashtag}")
  end

  def initial_start(tweet)
    new_board = Board.from_string("|.......|.......|.......|.......|.......|.......|")
    new_board.insert(4, "O")
    puts new_board.to_s
    Twitter.update("@#{tweet.from_user} #{new_board.to_twitter} #dbc_c4 ##{shuffle_hashtag}")
  end

  def accept_challenge(tweet)
    Twitter.update("@#{tweet.from_user} Game on! #dbc_c4 ##{shuffle_hashtag}")
  end

  def game_over?(tweet)
    tweet.text.include?("I win! Good game.") || tweet.text.include?("Draw game. Play again?")
  end

  def bot_piece(twitter_board)
    twitter_board.scan(/X/i).length == twitter_board.scan(/O/i).length ? "O" : "X"
  end

  def play_game(tweet)
    twitter_board = tweet.text.split(' ')[1]
    board = Board.from_string(twitter_board)
    board.insert(@ai.move(board, bot_piece(twitter_board)), bot_piece(twitter_board))
    if board.win?
      Twitter.update("@#{tweet.user[:screen_name]} #{board.to_twitter} I win! Good game. #dbc_c4 ##{shuffle_hashtag}")
    elsif !board.win? && board.full?
      Twitter.update("@#{tweet.user[:screen_name]} #{board.to_twitter} Draw game. Play again? #dbc_c4 ##{shuffle_hashtag}")
    else
      Twitter.update("@#{tweet.user[:screen_name]} #{board.to_twitter} #dbc_c4 ##{shuffle_hashtag}")
    end
  end
end