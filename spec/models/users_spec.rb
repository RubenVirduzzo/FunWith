
RSpec.describe User, type: :model do

    context "when user is empty" do
        it 'returns false' do
            expect(User.new.valid?).to be false
        end
    end

    context "when fullname field is empty" do
        it 'returns false' do
            user = User.create(username: "test_1", age: 25, email: "test@test.com")
            expect(user.valid?).to be false
        end
    end
end