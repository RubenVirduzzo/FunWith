class UserEventPreferencesController < ApplicationController
  before_action :set_user_event_preference, only: %i[ show edit update destroy ]

  # GET /user_event_preferences or /user_event_preferences.json
  def index
    @user_event_preferences = UserEventPreference.all
  end

  # GET /user_event_preferences/1 or /user_event_preferences/1.json
  def show
  end

  # GET /user_event_preferences/new
  def new
    @user_event_preference = UserEventPreference.new
  end

  # GET /user_event_preferences/1/edit
  def edit
  end

  # POST /user_event_preferences or /user_event_preferences.json
  def create
    @user_event_preference = UserEventPreference.new(user_event_preference_params)

    respond_to do |format|
      if @user_event_preference.save
        format.html { redirect_to user_event_preference_url(@user_event_preference), notice: "User event preference was successfully created." }
        format.json { render :show, status: :created, location: @user_event_preference }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_event_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_event_preferences/1 or /user_event_preferences/1.json
  def update
    respond_to do |format|
      if @user_event_preference.update(user_event_preference_params)
        format.html { redirect_to user_event_preference_url(@user_event_preference), notice: "User event preference was successfully updated." }
        format.json { render :show, status: :ok, location: @user_event_preference }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_event_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_event_preferences/1 or /user_event_preferences/1.json
  def destroy
    @user_event_preference.destroy

    respond_to do |format|
      format.html { redirect_to user_event_preferences_url, notice: "User event preference was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_event_preference
      @user_event_preference = UserEventPreference.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_event_preference_params
      params.require(:user_event_preference).permit(:user_id, :tag_id)
    end
end
