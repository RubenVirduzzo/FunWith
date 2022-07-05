class UserEventPreferencesController < ApplicationController
  before_action :set_user_event_preference, only: %i[ show edit update destroy ]

  def index
    @user_event_preferences = UserEventPreference.all
  end

  def show
  end

  def new
    @user_event_preference = UserEventPreference.new
  end

  def edit
  end

  def create
    @user_event_preference = UserEventPreference.create( user_id: params[:user_id], tag_id: params[:user_event_preference][:tag_id] )
    respond_to do |format|
      if @user_event_preference.save
        format.html { redirect_to "/users/#{ @user.id }/user_event_preferences" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    # current_user.preferences = params[:tag_id].reject{|element| element.blank? }
    @user_event_preference.tag_id = params[:user_event_preference][:tag_id].reject{|element| element.blank? }
    respond_to do |format|

      if @user_event_preference.valid?
        format.html { redirect_to "/users/#{ @user.id }/user_event_preferences", notice: "Preferences was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_event_preference.destroy

    respond_to do |format|
      format.html { redirect_to user_event_preferences_url, notice: "User event preference was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_user_event_preference
      @user_event_preference = UserEventPreference.find(params[:id])
    end

    def user_event_preference_params
      params.require(:user_event_preference).permit(:user_id, :tag_id)
    end
end
