RSpec.describe Inscription, type: :model do
  
  let(:user_params) do
    {
      fullname: "testino",
      username: "test",
      date_of_birth: Date.new(1991, 11, 26),
      email: "ciao@ciao.com",
      password: "123456"
    }
  end

  let(:event_params) do
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

  let(:user) { User.create(user_params) }

  let(:second_user) { User.create(user_params) }

  let(:event) { Event.create(event_params) }

  let(:second_event) { Event.create(event_params) }

  let(:inscription) { Inscription.create(event_id: event.id, user_id: user.id) }

  context 'when the user is not inscribed in the event yet' do
    subject { inscription.inscripted?(second_user, event) }

    it { is_expected.to be false }
  end

  context 'when the user is inscribed in the event' do
    subject { inscription.inscripted?(user, event) }

    #it { is_expected.to be true }
    it do
      user.inspect
      is_expected.to be true 
    end
  end

  context 'when the user is not inscribed in that event' do
    subject { inscription.inscripted?(user, second_event) }

    it { is_expected.to be false }
  end
end
