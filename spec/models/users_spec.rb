
RSpec.describe User, type: :model do

    context "when user is empty" do
        it 'returns false' do
            expect(User.new.valid?).to be false
        end
    end

end