RSpec.describe Tag, type: :model do

  describe 'validations' do

    context "when label field is empty" do
      it 'data invalid' do
        tag = build( :tag, label: "" )
        expect( tag.valid? ).to be false
      end
    end

    context "when description field is empty" do

      it 'data invalid' do
        tag = build( :tag, description: "" )
        expect( tag.valid? ).to be false
      end
    end
  end
end
