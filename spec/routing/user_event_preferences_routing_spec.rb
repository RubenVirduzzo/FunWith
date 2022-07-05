require "rails_helper"

RSpec.describe UserEventPreferencesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "users/1/user_event_preferences").to route_to("user_event_preferences#index", user_id: "1")
    end

    it "routes to #new" do
      expect(get: "users/1/user_event_preferences/new").to route_to("user_event_preferences#new", user_id: "1")
    end

    it "routes to #show" do
      expect(get: "users/1/user_event_preferences/1").to route_to("user_event_preferences#show", id: "1", user_id: "1")
    end

    it "routes to #edit" do
      expect(get: "users/1/user_event_preferences/1/edit").to route_to("user_event_preferences#edit", id: "1", user_id: "1")
    end


    it "routes to #create" do
      expect(post: "users/1/user_event_preferences").to route_to("user_event_preferences#create", user_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "users/1/user_event_preferences/1").to route_to("user_event_preferences#update", id: "1", user_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "users/1/user_event_preferences/1").to route_to("user_event_preferences#update", id: "1", user_id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "users/1/user_event_preferences/1").to route_to("user_event_preferences#destroy", id: "1", user_id: "1")
    end
  end
end
