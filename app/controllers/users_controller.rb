class UsersController < ApplicationController

  def show
    @user = current_user.twitter_client.user
    @feed = current_user.twitter_client.home_timeline
  end

  def unfollow
    current_user.twitter_client.unfollow(params[:user_id].to_i)
    redirect_to :back
  end

  def favorite
    current_user.twitter_client.favorite(params[:tweet_id])
    redirect_to :back
  end
end