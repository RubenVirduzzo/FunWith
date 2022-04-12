require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    assign(:event, Event.new(
      title: "MyString",
      description: "MyText",
      organizer: "MyString",
      place: "MyString",
      min_number_of_joiners: "MyString",
      max_number_of_joiners: "MyString",
      price: 1.5,
      min_age: 1
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input[name=?]", "event[title]"

      assert_select "textarea[name=?]", "event[description]"

      assert_select "input[name=?]", "event[organizer]"

      assert_select "input[name=?]", "event[place]"

      assert_select "input[name=?]", "event[min_number_of_joiners]"

      assert_select "input[name=?]", "event[max_number_of_joiners]"

      assert_select "input[name=?]", "event[price]"

      assert_select "input[name=?]", "event[min_age]"
    end
  end
end
