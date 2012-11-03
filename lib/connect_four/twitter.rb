require 'Twitter'
require 'tweetstream'
require_relative '../connect_four'

class Connect4Twitter

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

  # client = TweetStream::Client.new
  #
  # client.sitestream(['115192457'], :followings => true) do |status|
  #   puts status.inspect
  # end

  # def update(string)
  #   Twitter.update(string)
  # end

  def find_challenge
    Twitter.search("#dbc_c4", :result_type => "recent").results.map do |tweet|
      if "#{tweet.text}".match("Who wants to get demolished?")
        Twitter.update("@#{tweet.from_user} Game on! #dbc_c4", {:in_reply_to_status_id => '#{tweet.id}'})
      end
    end
  end

  # def send_challenge
  #   Twitter.update("Who wants to get demolished? #dbc_c4")
  # end
  #
  # def challenge_accepted?
  #   Twitter.search("#dbc_c4", :result_type => "recent").results.map do |tweet|
  #     if "#{tweet.text}".match("@connected_four Game on!")
  #       start_game(tweet)
  #     end
  #   end
  # end

  # def start_game(tweet)
    # board = Board.new
    # board.insert(4, 'X')

  #   p Twitter.update("@#{tweet.from_user} #{board.to_twitter} #dbc_c4", {:in_reply_to_status_id => '#{tweet.id}'})
  # end

  def continue_game#(tweet)
    # Twitter.search("to:connected_four").results.map do |tweet|
    #   p "@#{tweet.from_user} #{tweet.text}"
    #
    #   client.userstream do |status|
    #   name = status.user[:screen_name]
    #     if name == "connected_four"
    #     p Twitter.update("@#{tweet.from_user}")
    #     end
    TweetStream::Client.new.userstream do |status|
      p status.user[:screen_name]
      name = status.user[:screen_name]
      # unless status.text.include?("I win! Good game.") || status.text.include?("Draw game. Play again?")
         if name != "Connect4twenty" && status.text.include?("@Connect4twenty")
          #play game

          # begin
            board_string = status.text.split(' ')[1]
            p board_string
            board = Board.from_string(board_string)
            p "board: #{board.to_s}"
            board.insert((rand(7) + 1), "O")
            p "board after: #{board.to_s}"
            hashstr = ('a'..'z').to_a.shuffle[0..2].join
            Twitter.update("@#{status.user[:screen_name]} #{board.to_twitter} #dbc_c4 ##{hashstr}")
            puts "tweeted #{board.to_twitter}"
          # rescue Exception => e
            # p "something went wrong! oh snap.", e
          # end

      #   end
      end
    end
  end

# :in_reply_to_screen_name => "connected_four"
  # def accept_game
  #   Twitter.update("#{tweet.from_user} Game on! #dbc_c4")
  # end


end

puts "starting game"
bot = Connect4Twitter.new
puts "game started..."
# bot.find_game
puts "calling continue_game"
bot.continue_game
puts "called continue_game"

# bot.send_challenge
# bot.challenge_accepted?
# bot.update()
# Twitter.update("I'm tweeting with @gem!")
# Thread.new{@client_connected4.update("Game on! #dbc_c4")}
# bot.accept_game
  # def valid_game?
  # end
  #
  # def




















# ### Searching tweets for challenge
# check the dbc_c4 hashtag for tweets containing a challenge # find_game
#   check to see if that challenge has already been accepted # valid_game?
#     if yes, run the search again # find_game
#     if not, send the tweet to accept the challenge # accept_challenge
#       start the game # start_game
#
#
#
# ### Creating a challenge
# send a challenge tweet with the dbc_c4 hashtag # send_challenge
# check for accepted challenges # challenge_accepted?
#   if yes, start a game #start_game
#   if not, do nothing
#
#
# ### Game accepted/started
# retrieve modified board with opponents move # self.from_twitter(board)
#   analyze enemy move # enemy_move?
# send out board after our move, and including their previous move(s) # self.to_twitter(board)
