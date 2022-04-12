
RSpec.describe User, type: :model do

    describe 'validations' do

        let (:valid_user_params) do
            {
                fullname: "test",
                username: "test",
                date_of_birth: Date.new(1991, 11, 26),
                email: "ciao@ciao"
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
            let(:invalid_user_params) { valid_user_params.except(fullname: "test_test_test_test_test_test_test") }
                
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

        context "when date field is text" do
            let(:invalid_user_params) { valid_user_params.except(date_of_birth: "1991,11,26") }
                
            it 'data invalid' do
                user = User.new(invalid_user_params)
                expect(user.valid?).to be false
            end
        end

        context "when date of birth is in a string format" do

            let(:invalid_user_params) { valid_user_params.except(date_of_birth: "1991, 11, 26") }
                
            it 'data invalid' do
                user = User.new(invalid_user_params)
                expect(user.valid?).to be false
            end
        end

        context "check if user is underage" do
            
            let(:invalid_user_params) { valid_user_params.except(date_of_birth: Date.new(2006, 11, 26)) }
            
            before do
                travel_to Time.new(invalid_user_params[:date_of_birth].to_i)
            end
            
            after do
                travel_back
            end
            
            it 'to equal 17' do
                user = User.new(invalid_user_params)
                expect(user.age).to eq(17) 
            end

            it 'user underage' do
                user = User.new(invalid_user_params)
                expect(user.underage?).to be true 
            end
        end

        context "when email field has an invalid format" do
            
            let(:invalid_user_params) { valid_user_params.except(email: "poldo.com") }
                
            it 'data invalid' do
                user = User.new(invalid_user_params)
                expect(user.valid?).to be false
            end
        end
    end
end