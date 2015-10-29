require 'rails_helper'

RSpec.feature "TwitterServices:", type: :feature do

    user = User.create(name: "Mimi Schatz",
                      screen_name: "schatz_mc",
                      uid: "2359775539",
                      oauth_token: "2359775539-t86oIVjlNDR4xi9fmS2j8LLW7oos7YeMAVmwCGV",
                      oauth_token_secret: "jJ4qgeuThEcoAqkurOSzES0JHaBTXgOI0QaXmc2VIbGe3")

  it "#tweet_count" do
    VCR.use_cassette('twitter_user') do
      user = user.twitter_client.user
      expect(user.tweet_count).to eq(28)
    end
  end

  it "#follower_count" do
    VCR.use_cassette('twitter_user') do
      user = user.twitter_client.user
      expect(user.followers_count).to eq(68)
    end
  end

  it "#home_timeline" do
    VCR.use_cassette('twitter_user') do
      feed = user.twitter_client.home_timeline
      expect(feed.count).to eq(20)
    end
  end

  it "#friends_count" do
    VCR.use_cassette('twitter_user') do
      user = user.twitter_client.user
      expect(user.friends_count).to eq(118)
    end
  end

  it "#add_a_tweet" do
    VCR.use_cassette('twitter_user') do
      user = user.twitter_client.user
      expect(user.tweet_count).to eq(28)
      user.tweet("test")
      expect(user.tweet_count).to eq(29)
    end
  end
end