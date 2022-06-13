require 'rails_helper'

RSpec.describe "user_event_preferences/edit", type: :view do
  before(:each) do
    @user_event_preference = assign(:user_event_preference, UserEventPreference.create!(
      user_id: 1,
      tag_id: 1
    ))
  end

  it "renders the edit user_event_preference form" do
    render

    assert_select "form[action=?][method=?]", user_event_preference_path(@user_event_preference), "post" do

      assert_select "input[name=?]", "user_event_preference[user_id]"

      assert_select "input[name=?]", "user_event_preference[tag_id]"
    end
  end
end
