class HomeController < ApplicationController

  def index
  end

  def show_events
    @events = Event.all
  end

  def show_users
    @users = User.all
  end
end
