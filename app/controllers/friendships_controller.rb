class FriendshipsController < ApplicationController

  def create
    @user = User.find( params[ :id ] )
    @friendships = current_user.active_friendship.new( followed_id: @user.id )
    if @friendships.save
      redirect_to "/users/#{params[ :id ]}"
    else
      redirect_to "/users/#{params[ :id ]}"
    end
  end
  
  def destroy
    @friendships = Friendship.find_by( follower_user: current_user, followed_user: params[ :id ] )
    if @friendships.destroy
      redirect_to "/users/#{params[ :id ]}"
    else
      redirect_to "/users/#{params[ :id ]}"
    end
  end
end
