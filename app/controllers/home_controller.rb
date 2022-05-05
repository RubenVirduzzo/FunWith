class HomeController < ApplicationController

  def index
  end

  def show_events
    if user_session
      @events = Event.all
    else
      redirect_to "/"
    end
  end

  def show_users
    if user_session
      @users = User.all    
    else
      redirect_to "/"
    end
  end
end
