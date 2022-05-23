RSpec.describe Event, type: :model do

  describe 'validations' do

    context "when title field is empty" do
      it 'data invalid' do
        event = build( :event, title: "" )
        expect(event.valid?).to be false
      end
    end

    context "when title characters are overlength" do
      it 'data invalid' do
        event = build( :event, title: "test_test_test_test_test_test_test" )
        expect(event.valid?).to be false
      end
    end

    context "when description field is empty" do          
      it 'data invalid' do
        event = build( :event, description: "" )
        expect(event.valid?).to be false
      end
    end

    context "when date_event field is empty" do          
      it 'data invalid' do
        event = build( :event, date_event: "" )
        expect(event.valid?).to be false
      end
    end
  
    context "when duration_time field is empty" do          
      it 'data invalid' do
        event = build( :event, duration_time: "" )
        expect(event.valid?).to be false
      end
    end

    context "when place field is empty" do          
      it 'data invalid' do
        event = build( :event, place: "" )
        expect(event.valid?).to be false
      end
    end
    
    context "when min_age field is empty" do
      it 'data invalid' do
        event = build( :event, min_age: "" )
        expect(event.valid?).to be false
      end
    end

    context "when min_age field is a string" do
      it 'data invalid' do
        event = build( :event, min_age: "Poldo" )
        expect(event.valid?).to be false
      end
    end

    let(:new_user) { create( :user ) }
    let(:new_event) { create( :event, organizer_id: new_user.id ) }

    context 'when the event is not available to the user' do

      before { Inscription.create( event_id: new_event.id, user_id: new_user.id ) }      

      it { expect(Event.available_for(new_user)).to eq([]) }
    end

    context 'when the event is available to the user' do
      
      subject { Event.available_for(new_user) }
  
      it do
        is_expected.to_not be eq([]) 
      end
    end

    context 'when the event has place left' do
      
      subject { new_event.places_left }
  
      it do
        is_expected.to eq 10 
      end
    end

    context 'when the event has not place left' do
    
      subject do
        event = build( :event, max_number_of_joiners: 0 )
        event.places_left
      end
  
      it do
        is_expected.to eq 0
      end
    end

    context 'when the event is has not finisced the subscriptions' do
      
      subject { new_event.completed? }
  
      it do
        is_expected.to be false 
      end
    end

    context 'when the event has not place left' do
             
      subject do
        event = build( :event, max_number_of_joiners: 0 )
        event.completed?
      end
  
      it do
        is_expected.to be true
      end
    end
  end

  describe 'scopes' do

    let( :tag ) { create( :tag ) }
    let(:first_user) { create( :user ) }
    let(:second_user) { create( :user, fullname: "second_user", username: "second", date_of_birth: Date.new(2005, 11, 26), email: "second_user@usersecond.com", password: "123456" )}
    let!(:first_event) { create( :event, organizer_id: first_user.id, tag_ids: [tag.id] )}
    let!(:second_event) { create( :event, title: "second_event", date_event: "2023-06-16", place: "Rio Turia", organizer_id: second_user.id )}
    let!(:third_event) { create( :event, title: "third_event", date_event: "2023-06-18", place: "Rio Turia", organizer_id: second_user.id, tag_ids: [tag.id] )}
  
    context 'when filter is by location' do
    
      subject do
        events = Event.by_place( "Rio Turia" )
      end
    
      it "assigns events" do
        is_expected.to eq([ second_event, third_event ])
      end
    end
    
    context 'when the user filters by tag' do
    
      subject do
        events = Event.by_tag( tag.id )
      end
    
      it "assigns events" do
        is_expected.to eq([ first_event, third_event ])
      end
    end
    
    context 'when the user filters by tag and location' do
    
      subject do
        events = Event.by_tag( tag.id )
        events.by_place( "Rio Turia" )
      end
    
      it "assigns @events" do
        is_expected.to eq([ third_event ])
      end
    end
    
    context 'when the user filters by user' do
    
      subject do
        events = Event.by_organizer( second_user.username )
      end
        
      it "assigns @events" do
        is_expected.to eq([ second_event, third_event ])
      end
    end
    
    context 'when filters by date' do
    
      subject do
        events = Event.by_date( Date.new(2022,05,12) )
      end
      
      it "assigns @events" do
        is_expected.to eq([ second_event, third_event ])
      end
    end
  end
end