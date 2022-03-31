
RSpec.describe User, type: :model do

    context "when user is empty" do
        it 'returns false' do
            expect(User.new.valid?).to be false
        end
    end

    context "when fullname field is empty" do
        it 'returns false' do
            user = User.create(username: "test", age: 25, email: "test@test.com")
            expect(user.valid?).to be false
        end
    end

    context "when fullname characters are overlength" do
        it 'returns false' do
            user = User.create(fullname: "test_test_test_test_test_test_test", username: "test", age: 25, email: "test@test.com")
            expect(user.valid?).to be false
        end
    end

    context "when username field is empty" do
        it 'returns false' do
            user = User.create(fullname: "test", age: 25, email: "test@test.com")
            expect(user.valid?).to be false
        end
    end

    context "when age field is text" do
        it 'returns false' do
            user = User.create(fullname: "test", username: "test", age: "text", email: "test@test.com")
            expect(user.valid?).to be false
        end
    end

end