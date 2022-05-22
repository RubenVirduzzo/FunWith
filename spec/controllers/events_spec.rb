require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  
  let( :tag_first ) { create( :tag )}
  let(:tag_second) { create( :tag, label: "tag_second" )}
  let(:user_first) { create( :user ) }
  let(:user_second) { create( :user, fullname: "user_second", username: "second", date_of_birth: Date.new(2005, 11, 26), email: "user_second@usersecond.com", password: "123456" )}
  let!(:event_first) { create( :event, organizer_id: user_first.id, tag_ids: [ tag_first.id ] )}
  let!(:event_second) { create( :event, date_event: "2023-06-16", place: "Rio Turia", organizer_id: user_second.id, tag_ids: [tag_second.id] )}
  let!(:third_event) { create( :event, date_event: "2023-06-18", place: "Rio Turia", organizer_id: user_second.id, tag_ids: [tag_first.id] )}

  describe "GET 'index'" do

    context 'when there are no filters' do
      before { get :index }

      it "assigns @events" do
        expect(assigns(:events).count).to eq(3)
      end

      it "assigns all @events" do
        expect(assigns(:events).map(&:id)).to eq([ event_first.id, event_second.id, third_event.id ])
      end
    end

    context 'when the user filters by location' do
      before { get :index, params: { search: { place: "Rio Turia" }}}

      it "assigns @events" do
        expect(assigns(:events).map(&:id)).to eq([ event_second.id, third_event.id ])
      end
    end

    context 'when the user filters by tag' do
      before { get :index, params: { search: { tag_ids: tag_first.id }}}

      it "assigns @events" do
        expect(assigns(:events).map(&:id)).to eq([ event_first.id, third_event.id ])
      end
    end

    context 'when the user filters by tag and location' do
      before { get :index, params: { search: { tag_ids: tag_first.id, place: "Rio Turia" }}}

      it "assigns @events" do
        expect(assigns(:events).map(&:id)).to eq([ third_event.id ])
      end
    end

    context 'when the user filters by user' do
      before { get :index, params: { search: { organizer: user_second.username }}}

      it "assigns @events" do
        expect(assigns(:events).map(&:id)).to eq([ event_second.id, third_event.id ])
      end
    end

    context 'when the user is logged in' do
      before do 
        sign_in user_second
        Inscription.create(event_id: event_second.id, user_id: user_second.id)
        Inscription.create(event_id: third_event.id, user_id: user_second.id)
        get :index , params: { search: { available: true } }
      end

      it "assigns availables @events" do
        expect(assigns(:events).map(&:id)).to eq([ event_first.id ])
      end
    end

    context 'when filters by date' do
      before { get :index, params: { search: { date: Date.new(2022,05,12) }}}

      it "assigns @events" do
        expect(assigns(:events).map(&:id)).to eq([ event_second.id, third_event.id ])
      end
    end

  end
end