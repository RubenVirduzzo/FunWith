class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
  end

  def ban
    @user = User.find(params[:id])
    if current_user.role == "admin"
      @user.banned!
    end
    respond_to do |format|
      format.html { redirect_to "/users/#{@user.id}", notice: "#{@user.username} was successfully banned." }
      format.json { head :no_content }
    end
  end

  def unban
    @user = User.find(params[:id])
    if current_user.role == "admin"
      @user.member!
    end
    respond_to do |format|
      format.html { redirect_to "/users/#{@user.id}", notice: "#{@user.username} was successfully unbanned." }
      format.json { head :no_content }
    end
  end
end
