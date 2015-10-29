class UsersController < ApplicationController

  def unfollow
    current_user.unfollow(params[:id].to_i)
    redirect_to :back
  end
end