require 'rails_helper'

RSpec.describe "/events", type: :request do
  
  let(:tag) do
    Tag.create(
      label: "LabelTag", 
      description: "DescriptionTag"
    )
  end

  let(:user) do
    User.create(
      fullname: "testino",
      username: "test",
      date_of_birth: Date.new(1991, 11, 26),
      email: "ciao123@ciao.com",
      password: "123456"
    )
  end

  let(:valid_attributes) do
    { 
      title: "test0", 
      description: "a", 
      date_event: "2022-05-11T00:00:00", 
      duration_time: "10:15:00.000",
      place: "Malvarosa, Valencia",
      min_number_of_joiners: 1,
      max_number_of_joiners: 8,
      price: "5.0",
      min_age: "7",
      organizer_id: user.id,
      tag_ids: [tag.id]
    }
  end


  let(:invalid_attributes) {
    { 
      title: nil,
      description: "a", 
      date_event: "2022-05-11T00:00:00", 
      duration_time: "10:15:00.000",
      place: "Malvarosa, Valencia",
      min_number_of_joiners: 1,
      max_number_of_joiners: 8,
      price: "5.0",
      min_age: "7",
      organizer_id: user.id,
      tag_ids: [tag.id]
    }  
  }

  let(:new_attributes) do
    { 
      title: "test0", 
      description: "a", 
      date_event: "2022-05-11T00:00:00", 
      duration_time: "10:15:00.000",
      place: "Malvarosa, Valencia",
      min_number_of_joiners: 1,
      max_number_of_joiners: 8,
      price: "5.0",
      min_age: "7",
      organizer_id: user.id,
      tag_ids: [tag.id]
    }
  end

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      Event.create! valid_attributes
      get events_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      event = Event.create! valid_attributes
      get event_url(event)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      event = Event.create! valid_attributes
      get new_event_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      event = Event.create! valid_attributes
      get edit_event_url(event)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Event" do
        expect {
          post events_url, params: { event: valid_attributes }
        }.to change(Event, :count).by(1)
      end

      it "redirects to the created event" do
        post events_url, params: { event: valid_attributes }
        expect(response).to redirect_to(event_url(Event.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Event" do
        expect {
          post events_url, params: { event: invalid_attributes }
        }.to change(Event, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post events_url, params: { event: invalid_attributes }
        expect(response).to_not be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
  
      it "updates the requested event" do
        event = Event.create! new_attributes
        patch event_url(event), params: { event: new_attributes }
        event.reload
        expect(event.tags).to eq([tag])
      end

    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        event = Event.create! new_attributes
        patch event_url(event), params: { event: invalid_attributes}
        expect(response).to_not be_successful
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested event" do
      event = Event.create! valid_attributes
      expect {
        delete event_url(event)
      }.to change(Event, :count).by(-1)
    end

    it "redirects to the events list" do
      event = Event.create! valid_attributes
      delete event_url(event)
      expect(response).to redirect_to(events_url)
      end
    end
  end
end