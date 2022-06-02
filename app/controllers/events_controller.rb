class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: :index

  def index
    @events = Event.all
    @events = @events.by_tag(params.dig( :search, :tag_ids ).to_i) if params.dig( :search, :tag_ids )
    @events = @events.by_place( params.dig( :search, :place ) ) if params.dig( :search, :place) && params.dig( :search, :place) != ""
    @events = @events.by_organizer( params.dig( :search, :organizer ) ) if params.dig( :search, :organizer)
    @events = @events.by_date( params.dig( :search, :date ) ) if params.dig( :search, :date) 
    @events = @events.by_follows( current_user.followed_user.map(&:id) ) if params.dig( :search, :follows ) == "true"
    @events = @events.available_for(current_user) if params.dig( :search, :available ) == "true"
    @events = User.find(params.dig( :search, :user_id ) ).inscriptions.map(&:event) if params.dig( :search, :user_id )
    
    @events
  end

  def show
    @event
  end
  
  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @location = Location.find_by( address: @event.place ) ? nil : Location.create({"address" => event_params[:place]}) 
    @event.organizer_id = current_user.id
    respond_to do |format|
      if @event.save 
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    @location = Location.find_by( address: @event.place ) ? nil : Location.create({"address" => event_params[:place]}) 
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :date_event, :duration_time,
                                  :place, :min_number_of_joiners, :max_number_of_joiners, 
                                  :price, :min_age, :image,  tag_ids: [] )
  end

  # def available_for_current_user?
  #   current_user.present? && params.dig( :search, :available ) == "true"
  # end
end
