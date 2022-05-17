require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  
  let( :tag_first ) { Tag.create( label: "tag_first", description: "DescriptionTag" )}
  let(:tag_second) { Tag.create( label: "tag_second", description: "DescriptionTag" )}
  let(:user_first) { User.create( fullname: "user_first", username: "first", date_of_birth: Date.new(1991, 11, 26), email: "user_first@userfirst.com", password: "123456" )}
  let(:user_second) { User.create( fullname: "user_second", username: "second", date_of_birth: Date.new(2005, 11, 26), email: "user_second@usersecond.com", password: "123456" )}
  let!(:event_first) { Event.create( title: "event_first", description: "first", date_event: "2022-05-11T00:00:00", duration_time: "10:15:00.000", place: "Malvarosa", min_number_of_joiners: 1, max_number_of_joiners: 8, price: "5.0", min_age: "18", organizer_id: user_first.id, tag_ids: [tag_first.id] )}
  let!(:event_second) { Event.create( title: "event_second", description: "second", date_event: "2022-05-16T00:00:00", duration_time: "10:15:00.000", place: "Rio Turia", min_number_of_joiners: 1, max_number_of_joiners: 8, price: "5.0", min_age: "18", organizer_id: user_second.id, tag_ids: [tag_second.id] )}

  describe "GET 'index'" do
    
    context 'when there are no filters' do
      before { get :index }

      it "assigns @events" do
        expect(assigns(:events).count).to eq(2)
      end

      it "assigns all @events" do
        expect(assigns(:events).map(&:id)).to eq([ event_first.id, event_second.id])
      end
    end

    context 'when the user filters by location' do
      before { get :index, params: { search: { place: "Rio Turia" } }}

      it "assigns @events" do
        expect(assigns(:events).map(&:id)).to eq([ event_second.id ])
      end
    end

  end
end