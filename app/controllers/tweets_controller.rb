class TweetsController < ApplicationController

  def create
    current_user.tweet(params[:tweet])
    redirect_to profile_path
  end

  def retweet
    current_user.retweet(params[:tweet_id])
    redirect_to profile_path
  end
end