include ActiveSupport::Testing::TimeHelpers
RSpec.describe User, type: :model do

  describe 'validations' do

    let (:valid_user_params) do
      {
        fullname: "test",
        username: "test",
        date_of_birth: DateTime.new(1991,11,26),
        email: "ciao@ciao.com",
        password: "123456"
      }
    end

    context "when fullname field is empty" do

      let(:invalid_user_params) { valid_user_params.except(:fullname) }
          
      it 'data invalid' do
        user = User.new(invalid_user_params)
        expect(user.valid?).to be false
      end
    end

    context "when fullname characters are overlength" do
      let(:invalid_user_params) { valid_user_params.merge(fullname: "test_test_test_test_test_test_test") }
          
      it 'data invalid' do
        user = User.new(invalid_user_params)
        expect(user.valid?).to be false
      end
    end

    context "when username field is empty" do
      let(:invalid_user_params) { valid_user_params.except(:username) }
          
      it 'data invalid' do
        user = User.new(invalid_user_params)
        expect(user.valid?).to be false
      end
    end

    context "when date of birth is in a string format" do
      let(:invalid_user_params) { valid_user_params.merge(date_of_birth: "1991,11,26") }
          
      it 'data invalid' do
        user = User.new(invalid_user_params)
        expect(user.valid?).to be false
      end
    end
    
    context "check if user is underage" do
      before do
        travel_to Time.zone.now.prev_year
      end
      
      after do
        travel_back
      end
      
      let(:invalid_user_params) { valid_user_params.merge(date_of_birth: DateTime.new(2004,04,26))}
      
      it 'to equal 17' do
        user = User.new(invalid_user_params)
        expect(user.age).to eq(17) 
      end

      it 'user underage' do
        user = User.new(invalid_user_params)
        expect(user.underage?).to be true 
      end
    end

    context "check if user is major" do
      before do
        travel_to Time.zone.now.next_year
      end
      
      after do
        travel_back
      end
      
      let(:invalid_user_params) { valid_user_params.merge(date_of_birth: DateTime.new(2004,04,26))}
      
      it 'to equal 17' do
        user = User.new(invalid_user_params)
        expect(user.age).to eq(19) 
      end

      it 'user underage' do
        user = User.new(invalid_user_params)
        expect(user.underage?).to be false
      end
    end
    
    context "when email field has an invalid format" do
      let(:invalid_user_params) { valid_user_params.merge(email: "poldo.com") }

          
      it 'data invalid' do
        user = User.new(invalid_user_params)
        expect(user.valid?).to be false
      end
    end
  end
end