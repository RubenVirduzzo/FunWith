class InscriptionsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_inscription , only: :destroy

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
    return format.html { redirect_to event_url(@event), notice: "inscription was successfully created." } if current_user.banned?
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

  def update
    respond_to do |format|
      if @inscription.update(inscription_params)
        format.html { redirect_to event_url(@event), notice: "inscription was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @inscription.destroy 
      respond_to do |format|
        format.html { redirect_to event_url(@event), notice: "inscription was successfully deleted." }
      end
    else
      respond_to do |format|
        format.html { redirect_to event_url(@event), notice: "Can't delete inscription." }
      end
    end
  end

  private

    def inscription_params
      params.permit(:event_id, :id)
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_inscription
      @inscription = Inscription.find(params[:id])
    end
end
