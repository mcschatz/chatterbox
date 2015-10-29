require 'rails_helper'

RSpec.feature "User", type: :feature do

    user = User.create(name: "Mimi Schatz",
                      screen_name: "schatz_mc",
                      uid: "2359775539",
                      oauth_token: "2359775539-t86oIVjlNDR4xi9fmS2j8LLW7oos7YeMAVmwCGV",
                      oauth_token_secret: "jJ4qgeuThEcoAqkurOSzES0JHaBTXgOI0QaXmc2VIbGe3")

  it "#tweet_count" do
    VCR.use_cassette('twitter_user') do
      twitter_user = user.twitter_client.user
      expect(twitter_user.tweets_count).to eq(28)
    end
  end

  it "#follower_count" do
    VCR.use_cassette('twitter_user') do
      twitter_user = user.twitter_client.user
      expect(twitter_user.followers_count).to eq(68)
    end
  end

  it "#home_timeline" do
    VCR.use_cassette('twitter_user') do
      feed = user.twitter_client.home_timeline
      expect(feed.count).to eq(19)
    end
  end

  it "#friends_count" do
    VCR.use_cassette('twitter_user') do
      twitter_user = user.twitter_client.user
      expect(twitter_user.friends_count).to eq(117)
    end
  end
end