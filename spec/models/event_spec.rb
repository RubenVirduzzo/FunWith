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
end