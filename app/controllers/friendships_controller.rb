class FriendshipsController < ApplicationController
  
  def create
    @followed_user = User.find( params[ :friendships ] [ :followed_id ] )
    @friendships = current_user.active_friendships.new( followed_id: @followed_user.id )
    if @friendships.save
      flash[ :message ] = "Follow Successful"
    else
      flash[ :message ] = "Follow Unuccessful"
    end
  end
  
  def destroy
    @friendships = friendships.find( params[ :id ] )
    if @friendships.follower_user = current_user
      @friendships.destroy
      flash[ :message ] = "Unfollowed"
    else
      flash[ :message ] = "Unfollowed Unuccessful"
    end
  end
end
