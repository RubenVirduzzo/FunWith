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
        organizer_id: 1
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

      let(:invalid_event_params) { valid_event_params.merge(min_age: "string") }
          
      it 'data invalid' do
        event = Event.new(invalid_event_params)
        expect(event.valid?).to be false
      end
    end
  end
end