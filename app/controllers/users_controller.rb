class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @friend_list = @user.followed_user if params.dig( :search, :followed )
    @friend_list = @user.follower_user if params.dig( :search, :follower )
    @user_position = request.location
  end

  def ban
    @user = User.find(params[:id])
    if current_user.admin?
      @user.banned!
    end
    respond_to do |format|
      format.html { redirect_to "/users/#{@user.id}", notice: "#{@user.username} was successfully banned." }
    end
  end

  def unban
    @user = User.find(params[:id])
    if current_user.admin?
      @user.member!
    end
    respond_to do |format|
      format.html { redirect_to "/users/#{@user.id}", notice: "#{@user.username} was successfully unbanned." }
    end
  end
end
