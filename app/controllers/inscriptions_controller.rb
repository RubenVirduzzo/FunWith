class InscriptionsController < ApplicationController
  before_action :set_event, only: :create 

  def index
    @inscriptions = Inscription.where(user_id: current_user.id)
  end

  def show
    
  end

  def new
    @inscription = Inscription.new
  end

  def edit
  end

  def create

    @inscription = Inscription.new(inscription_params)
    @inscription.user_id = current_user.id
    respond_to do |format|
      if @inscription.save
        format.html { redirect_to event_url(@event), notice: "inscription was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inscriptions/1 or /inscriptions/1.json
  def update
    respond_to do |format|
      if @inscription.update(inscription_params)
        format.html { redirect_to inscription_url(@inscription), notice: "inscription was successfully updated." }
        format.json { render :show, status: :ok, location: @inscription }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @inscription.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @event = Event.find(params[:event_id])
    @inscription = current_user.events.find_by(id: @event.id)
    current_user.events.destroy(@inscription)

    respond_to do |format|
      format.html { redirect_to event_url(@event), notice: "inscription was successfully deleted." }
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def inscription_params
      params.permit(:event_id)
    end

    def set_event
      @event = Event.find(params[:event_id])
    end
end
