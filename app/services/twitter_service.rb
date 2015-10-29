class TwitterService
  attr_reader :connection

  def initialize(user)
    @connection ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_publishable_key"]
      config.consumer_secret     = ENV["twitter_secret_key"]
      config.access_token        = user.oauth_token
      config.access_token_secret = user.oauth_token_secret
    end
  end

  def home_timeline
    connection.home_timeline
  end

  def follower_count
    connection.user.followers_count
  end

  def tweet_count
    connection.user.tweets_count
  end

  def friends_count
    connection.user.friends_count
  end

  def tweet(tweet)
    connection.update(tweet)
  end

  def favorite(tweet)
    connection.favorite(tweet)
  end

  def retweet(tweet)
    connection.retweet(tweet)
  end

  def unfollow(friend)
    connection.unfollow(friend)
  end

  def reply(user)
    connection.in_reply_to_user_id(user)
  end
end