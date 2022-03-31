
RSpec.describe User, type: :model do

    describe 'validations' do
        context "when fullname field is empty" do
            it 'data invalid' do
                user = User.new(username: "test", age: 25, email: "test@test.com")
                expect(user.valid?).to be false
            end
        end

        context "when fullname characters are overlength" do
            it 'data invalid' do
                user = User.new(fullname: "test_test_test_test_test_test_test", username: "test", age: 25, email: "test@test.com")
                expect(user.valid?).to be false
            end
        end

        context "when username field is empty" do
            it 'data invalid' do
                user = User.new(fullname: "test", age: 25, email: "test@test.com")
                expect(user.valid?).to be false
            end
        end

        context "when age field is text" do
            it 'data invalid' do
                user = User.new(fullname: "test", username: "test", age: "text", email: "test@test.com")
                expect(user.valid?).to be false
            end
        end

        context "when email field has an invalid format" do
            it 'data invalid' do
                user = User.new(fullname: "test", username: "test", age: 25, email: "testtest.com")
                expect(user.valid?).to be false
            end
        end

        context "when all fields have the correct format" do
            it 'returns true' do
                user = User.new(fullname: "test", username: "test", age: 25, email: "test@test.com")
                expect(user.valid?).to be true
            end
        end
    end
end