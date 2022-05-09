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

  def show_subscriptions
    if user_session
      @events = current_user.events.all
    else
     redirect_to "/"
    end
  end

  def show_availables
    if user_session
      @events = Event.available_for(current_user)
    else
      redirect_to "/"
    end
  end

end
