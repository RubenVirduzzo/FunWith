require 'rails_helper'

RSpec.describe "user_event_preferences/show", type: :view do
  before(:each) do
    @user_event_preference = assign(:user_event_preference, UserEventPreference.create!(
      user_id: 2,
      tag_id: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
