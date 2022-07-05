class UserEventPreferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_event_preference, only: %i[ show edit update destroy ]
  before_action :set_tags
  before_action :set_user_preferences
  before_action :set_ids

  def index
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
      format.html { redirect_to "/users/#{ @user.id }/user_event_preferences" }
    end
  end

  private
    def set_user_event_preference
      @user_event_preference =  UserEventPreference.find(params[:id])
    end

    def set_tags
      @tags = Tag.all
    end

    def set_user_preferences
      @user = User.find(params[:user_id]) 
      @user_preferences = @user.preferences
    end
    
    def set_ids
      @ids = []
    
      @user_preferences.each do |preference|
        @ids << preference.tag_id 
      end 
    end

    def user_event_preference_params

      params.require(:user_event_preference).permit( :user_id, :tag_id )
    end
end
