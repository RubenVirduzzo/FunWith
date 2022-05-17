class HomeController < ApplicationController
  
  def index
  end

  def show_events
    if user_session
      @events = Event.all
    else
     redirect_to :root
    end
  end

  def show_users
    if user_session
      @users = User.all  
      else
       redirect_to :root
      end  
  end

  def show_subscriptions
    if user_session
      @events = current_user.events.all
    else
     redirect_to :root
    end
  end

  def show_availables
    if user_session
      @events = Event.available_for(current_user)
    else
      redirect_to :root
    end
  end

  def show_tags
    if user_session
      @tags = Tag.all
    else
      redirect_to :root
    end
  end

  def show_one_tag
    if user_session    
      @events = []
      Event.all.select{ |event| @events << event if event.tag_ids.include?(params[:id].to_i) }
       @events
    else
      redirect_to :root
    end
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

end
