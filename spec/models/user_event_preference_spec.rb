require 'rails_helper'

RSpec.describe UserEventPreference, type: :model do
  
  let( :user_params ) { create( :user ) }

  let( :second_user ) { create( :user, username: "orazio", email: "ciao2@ciao.com" ) } 

  let!( :tag_params ) { create( :tag ) }

  let!( :second_tag ) { create( :tag, label: "volleyball" ) }

  let!(:event_params) { create( :event ) }

  let!(:second_event) { create( :event, title: "second_event" ) }

  let!( :preferences ) { create(:user_event_preference, user_id: user_params.id, tag_id: tag_params.id) }

  context 'when the user_params is not inscribed in the event yet' do
    subject { second_user.has_preference?(preference.id) }

    it { is_expected.to be false }
  end

  context 'when the user_params is inscribed in the event' do
    subject { user_params.has_preference?(preference.id) }

    it { is_expected.to be true }
  end

  context 'when the user_params is not inscribed in that event' do
    subject { second_user.has_preference?(preference.id) }

    it { is_expected.to be false }
  end
end
