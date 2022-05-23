RSpec.describe Inscription, type: :model do

  let( :user_params ) { create( :user ) }

  let( :second_user ) { create( :user, username: "orazio", email: "ciao2@ciao.com" ) } 

  let!( :event_params ) { create( :event, organizer_id: user_params.id ) }

  let!( :second_event ) { create( :event, organizer_id: second_user.id ) }

  let!( :inscription ) { Inscription.create(event_id: event_params.id, user_id: user_params.id) }

  context 'when the user_params is not inscribed in the event yet' do
    subject { second_user.inscripted?(event_params) }

    it { is_expected.to be false }
  end

  context 'when the user_params is inscribed in the event' do
    subject { user_params.inscripted?(event_params) }

    it { is_expected.to be true }
  end

  context 'when the user_params is not inscribed in that event' do
    subject { user_params.inscripted?(second_event) }

    it { is_expected.to be false }
  end
end
