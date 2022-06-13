require 'rails_helper'

RSpec.describe "user_event_preferences/new", type: :view do
  before(:each) do
    assign(:user_event_preference, UserEventPreference.new(
      user_id: 1,
      tag_id: 1
    ))
  end

  it "renders new user_event_preference form" do
    render

    assert_select "form[action=?][method=?]", user_event_preferences_path, "post" do

      assert_select "input[name=?]", "user_event_preference[user_id]"

      assert_select "input[name=?]", "user_event_preference[tag_id]"
    end
  end
end
