class UsersController < ApplicationController

  def unfollow
    current_user.unfollow(params[:user_id].to_i)
    redirect_to :back
  end

  def favorite
    current_user.favorite(params[:tweet_id])
    redirect_to :back
  end
end