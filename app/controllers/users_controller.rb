class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
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
