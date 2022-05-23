include ActiveSupport::Testing::TimeHelpers
RSpec.describe User, type: :model do

  describe 'validations' do

    context "when fullname field is empty" do          
      it 'data invalid' do
        user = build( :user, fullname: "" )
        expect( user.valid? ).to be false
      end
    end

    context "when fullname characters are overlength" do          
      it 'data invalid' do
        user = build( :user, fullname: "test_test_test_test_test_test_test" )
        expect(user.valid?).to be false
      end
    end

    context "when username field is empty" do          
      it 'data invalid' do
        user = build( :user, username: "" )
        expect(user.valid?).to be false
      end
    end

    context "when date of birth is in a string format" do          
      it 'data invalid' do
        user = build( :user, date_of_birth: "1991,11,26" )
        expect(user.valid?).to be false
      end
    end
    
    context "check if user is underage" do
      let(:user) { build( :user, date_of_birth: DateTime.new(2004,04,26) )}

      before do
        travel_to Time.zone.now.prev_year
      end
      
      after do
        travel_back
      end
      
      it 'to equal 17' do
        expect(user.age).to eq(17) 
      end

      it 'user underage' do
        expect(user.underage?).to be true 
      end
    end

    context "check if user is major" do
      let(:user) { build( :user, date_of_birth: DateTime.new(2004,04,26) )}
      
      before do
        travel_to Time.zone.now.next_year
      end
      
      after do
        travel_back
      end
          
      it 'to equal 19' do
        expect(user.age).to eq(19) 
      end

      it 'user underage' do
        expect(user.underage?).to be false
      end
    end
    
    context "when email field has an invalid format" do
      it 'data invalid' do
        user = build( :user, email: "poldo.com" )
        expect(user.valid?).to be false
      end
    end
  end
end