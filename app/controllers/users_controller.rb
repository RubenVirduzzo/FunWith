class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @friend_list = @user.followed_user
    if params.dig( :search, :follower )
      @friend_list = @user.follower_user 
      @active = true
    end

  end

  def ban
    @user = User.find(params[:id])
    @user.banned! if current_user.admin?
    
    respond_to do |format|
      format.html { redirect_to "/users/#{@user.id}", notice: "#{@user.username} was successfully banned." }
    end
  end

  def unban
    @user = User.find(params[:id])
    @user.member! if current_user.admin?
    
    respond_to do |format|
      format.html { redirect_to "/users/#{@user.id}", notice: "#{@user.username} was successfully unbanned." }
    end
  end
end
