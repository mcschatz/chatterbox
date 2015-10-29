class TweetsController < ApplicationController

  def create
    current_user.twitter_client.update(params[:tweet])
    redirect_to profile_path
  end

  def retweet
    current_user.twitter_client.retweet(params[:tweet_id])
    redirect_to profile_path
  end
end