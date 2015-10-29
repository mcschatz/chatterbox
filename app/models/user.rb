class User < ActiveRecord::Base

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
    @connection ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_publishable_key"]
      config.consumer_secret     = ENV["twitter_secret_key"]
      config.access_token        = oauth_token
      config.access_token_secret = oauth_token_secret
    end
  end
end