require 'rails_helper'

RSpec.describe "/", type: :request do
  
  let( :tag_first ) { Tag.create( label: "tag_first", description: "DescriptionTag" )}

  let(:tag_second) { Tag.create( label: "tag_second", description: "DescriptionTag" )}

  let(:user_first) { User.create( fullname: "user_first", username: "test", date_of_birth: Date.new(1991, 11, 26), email: "test123@test.com", password: "123456" )}

  let(:user_second) { User.create( fullname: "user_second", username: "test", date_of_birth: Date.new(2005, 11, 26), email: "testtest123@test.com", password: "123456" )}

  let(:event_first) { Event.create( title: "event_first", description: "a", date_event: "2022-05-11T00:00:00", duration_time: "10:15:00.000", place: "Malvarosa, Valencia", min_number_of_joiners: 1, max_number_of_joiners: 8, price: "5.0", min_age: "7", organizer_id: user.id, tag_ids: [tag.id] )}

  let(:event_second) { Event.create( title: "event_second", description: "a", date_event: "2022-05-11T00:00:00", duration_time: "10:15:00.000", place: "Malvarosa, Valencia", min_number_of_joiners: 1, max_number_of_joiners: 8, price: "5.0", min_age: "7", organizer_id: user.id, tag_ids: [tag.id] )}

  before do 
    sign_in user_first
    sign_in user_second
  end

  describe "GET /index" do
    it "renders a successful response" do
      get "/"
      expect(response).to be_successful
    end
  end

  describe "GET /show_events" do
    it "returns all events" do
      
    end
  end

  describe "GET /show_availables" do
    it "returns all events availables" do
      
    end
  end

  describe "GET /show_subscriptions" do
    it "returns all events where the user is subscribed at" do
      
    end
  end

  describe "GET /show_by_date" do
    it "returns all events post date selected" do
      
    end
  end

  describe "GET /show_by_tags" do
    it "returns all events that contain the tag selected" do

    end
  end

  describe "GET /show_by_location" do
    it "returns all events with the location selected" do
  
    end
  end

  describe "GET /show_by_user" do
    it "returns all events created by the user selected" do
      
    end
  end
end