class User < ActiveRecord::Base
  delegate :home_timeline,
           :user_timeline,
           :follower_count,
           :tweet_count,
           :friends_count,
           :mentions,
           :tweet,
           :favorite,
           :unfavorite,
           :retweet,
           :unfollow, to: :twitter_client

  def self.from_omniauth(auth_info)
    user = User.find_or_create_by(uid: auth_info.uid)

    user.update_attributes(
      screen_name:        auth_info.info.nickname,
      name:               auth_info.info.name,
      email:              auth_info.info.email,
      location:           auth_info.info.location,
      image:              auth_info.info.image,
      description:        auth_info.info.description,
      urls:               auth_info.info.urls,
      oauth_token:        auth_info.credentials.token,
      oauth_token_secret: auth_info.credentials.secret
    )
    user
  end

  def twitter_client
    @service ||= TwitterService.new(self)
  end
end