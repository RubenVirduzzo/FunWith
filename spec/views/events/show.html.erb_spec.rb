require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      title: "Title",
      description: "MyText",
      organizer: "Organizer",
      place: "Place",
      min_number_of_joiners: "Min Number Of Joiners",
      max_number_of_joiners: "Max Number Of Joiners",
      price: 2.5,
      min_age: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Organizer/)
    expect(rendered).to match(/Place/)
    expect(rendered).to match(/Min Number Of Joiners/)
    expect(rendered).to match(/Max Number Of Joiners/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3/)
  end
end
