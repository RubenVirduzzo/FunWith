require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        title: "Title",
        description: "MyText",
        organizer: "Organizer",
        place: "Place",
        min_number_of_joiners: "Min Number Of Joiners",
        max_number_of_joiners: "Max Number Of Joiners",
        price: 2.5,
        min_age: 3
      ),
      Event.create!(
        title: "Title",
        description: "MyText",
        organizer: "Organizer",
        place: "Place",
        min_number_of_joiners: "Min Number Of Joiners",
        max_number_of_joiners: "Max Number Of Joiners",
        price: 2.5,
        min_age: 3
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "Organizer".to_s, count: 2
    assert_select "tr>td", text: "Place".to_s, count: 2
    assert_select "tr>td", text: "Min Number Of Joiners".to_s, count: 2
    assert_select "tr>td", text: "Max Number Of Joiners".to_s, count: 2
    assert_select "tr>td", text: 2.5.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
