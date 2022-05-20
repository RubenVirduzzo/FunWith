RSpec.describe Event, type: :model do

  describe 'validations' do

    let (:valid_event_params) do
      {
        title: "testino",
        description: "descriptfull description",
        date_event: Date.new(2022, 7, 26),
        duration_time: Date.new(2022, 7, 26),
        place: "Rio Turia, Valencia",
        min_number_of_joiners: 2,
        max_number_of_joiners: 10,
        price: 10.00,
        min_age: 18,
        organizer_id: user.id
      }
    end
    
    let(:valid_user_params) do
      {
        fullname: "testino",
        username: "test",
        date_of_birth: Date.new(1991, 11, 26),
        email: "ciao@ciao.com",
        password: "123456"
      }
    end

    context "when title field is empty" do

      let( :invalid_event_params ) { valid_event_params.except( :title ) }
          
      it 'data invalid' do
        event = Event.new(invalid_event_params)
        expect(event.valid?).to be false
      end
    end

    context "when title characters are overlength" do

      let( :invalid_event_params ) { valid_event_params.merge( title: "test_test_test_test_test_test_test" ) }
          
      it 'data invalid' do
        event = Event.new(invalid_event_params)
        expect(event.valid?).to be false
      end
    end

    context "when description field is empty" do

      let(:invalid_event_params) { valid_event_params.except(:description) }
          
      it 'data invalid' do
        event = Event.new(invalid_event_params)
        expect(event.valid?).to be false
      end
    end

    context "when date_event field is empty" do

      let(:invalid_event_params) { valid_event_params.except(:date_event) }
          
      it 'data invalid' do
        event = Event.new(invalid_event_params)
        expect(event.valid?).to be false
      end
    end
  
    context "when duration_time field is empty" do

      let(:invalid_event_params) { valid_event_params.except(:duration_time) }
          
      it 'data invalid' do
        event = Event.new(invalid_event_params)
        expect(event.valid?).to be false
      end
    end

    context "when place field is empty" do

      let(:invalid_event_params) { valid_event_params.except(:place) }
          
      it 'data invalid' do
        event = Event.new(invalid_event_params)
        expect(event.valid?).to be false
      end
    end
    
    context "when min_age field is empty" do

      let(:invalid_event_params) { valid_event_params.except(:min_age) }
          
      it 'data invalid' do
        event = Event.new(invalid_event_params)
        expect(event.valid?).to be false
      end
    end

    context "when min_age field is a string" do

      let(:invalid_event_params) { valid_event_params.merge(min_age: "Poldo") }
          
      it 'data invalid' do
        event = Event.create(invalid_event_params)
        expect(event.valid?).to be false
      end
    end

    let(:user) { User.create(valid_user_params) }

    let!(:event) { Event.create(valid_event_params) }
    
    context 'when the event is not available to the user' do
  
      before { Inscription.create(event_id: event.id, user_id: user.id) }      

      it { expect(Event.available_for(user)).to eq([]) }
    end

    context 'when the event is available to the user' do
      
      subject { Event.available_for(user) }
  
      it do
        is_expected.to_not be eq([]) 
      end
    end

    context 'when the event has place left' do
      
      subject { event.places_left }
  
      it do
        is_expected.to eq 10 
      end
    end

    context 'when the event has not place left' do
      
      let( :invalid_event_params ) { valid_event_params.merge( max_number_of_joiners: 0 ) }
       
      subject do
        event = Event.create(invalid_event_params)
        event.places_left
      end
  
      it do
        is_expected.to eq 0
      end
    end

    context 'when the event is has not finisced the subscriptions' do
      
      subject { event.completed? }
  
      it do
        is_expected.to be false 
      end
    end

    context 'when the event has not place left' do
      
      let( :invalid_event_params ) { valid_event_params.merge( max_number_of_joiners: 0 ) }
       
      subject do
        event = Event.create(invalid_event_params)
        event.completed?
      end
  
      it do
        is_expected.to be true
      end
    end
  end

  describe 'scopes' do

    let( :first_tag ) { Tag.create( label: "first_tag", description: "DescriptionTag" )}
    let(:second_tag) { Tag.create( label: "second_tag", description: "DescriptionTag" )}
    let(:first_user) { User.create( fullname: "first_user", username: "first", date_of_birth: Date.new(1991, 11, 26), email: "first_user@userfirst.com", password: "123456" )}
    let(:second_user) { User.create( fullname: "second_user", username: "second", date_of_birth: Date.new(2005, 11, 26), email: "second_user@usersecond.com", password: "123456" )}
    let!(:first_event) { Event.create( title: "first_event", description: "first", date_event: "2022-05-11", duration_time: "10:15:00.000", place: "Malvarosa", min_number_of_joiners: 1, max_number_of_joiners: 8, price: "5.0", min_age: "18", organizer_id: first_user.id, tag_ids: [first_tag.id] )}
    let!(:second_event) { Event.create( title: "second_event", description: "second", date_event: "2023-06-16", duration_time: "10:15:00.000", place: "Rio Turia", min_number_of_joiners: 1, max_number_of_joiners: 8, price: "5.0", min_age: "18", organizer_id: second_user.id, tag_ids: [second_tag.id] )}
    let!(:third_event) { Event.create( title: "third_event", description: "third", date_event: "2023-06-18", duration_time: "10:15:00.000", place: "Rio Turia", min_number_of_joiners: 1, max_number_of_joiners: 8, price: "5.0", min_age: "18", organizer_id: second_user.id, tag_ids: [first_tag.id] )}
  
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
        events = Event.by_tag( first_tag.id )
      end
    
      it "assigns events" do
        is_expected.to eq([ first_event, third_event ])
      end
    end
    
    context 'when the user filters by tag and location' do
    
      subject do
        events = Event.by_tag( first_tag.id )
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