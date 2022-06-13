require 'rails_helper'

RSpec.describe "user_event_preferences/index", type: :view do
  before(:each) do
    assign(:user_event_preferences, [
      UserEventPreference.create!(
        user_id: 2,
        tag_id: 3
      ),
      UserEventPreference.create!(
        user_id: 2,
        tag_id: 3
      )
    ])
  end

  it "renders a list of user_event_preferences" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
