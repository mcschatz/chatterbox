require 'rails_helper'

RSpec.feature "TwitterServices:", type: :feature do

    user = User.create(name: "Mimi Schatz",
                      screen_name: "schatz_mc",
                      uid: "2359775539",
                      oauth_token: "2359775539-t86oIVjlNDR4xi9fmS2j8LLW7oos7YeMAVmwCGV",
                      oauth_token_secret: "jJ4qgeuThEcoAqkurOSzES0JHaBTXgOI0QaXmc2VIbGe3")

  it "#tweet_count" do
    VCR.use_cassette('twitter_user') do
      service = TwitterService.new(user)
      user_tweet_count = service.tweet_count
      expect(user_tweet_count).to eq(28)
    end
  end

  it "#follower_count" do
    VCR.use_cassette('twitter_user') do
      service = TwitterService.new(user)
      user_follower_count = service.follower_count
      expect(user_follower_count).to eq(68)
    end
  end

  it "#home_timeline" do
    VCR.use_cassette('twitter_user') do
      service = TwitterService.new(user)
      user_home_timeline = service.home_timeline
      expect(user_home_timeline.count).to eq(18)
    end
  end

  it "#friends_count" do
    VCR.use_cassette('twitter_user') do
      service = TwitterService.new(user)
      user_friends_count = service.friends_count
      expect(user_friends_count).to eq(118)
    end
  end

  it "#add_a_tweet" do
    VCR.use_cassette('twitter_user') do
      service = TwitterService.new(user)
      expect(service.tweet_count).to eq(28)
      service.tweet("test")
      expect(service.tweet_count).to eq(29)
    end
  end
end