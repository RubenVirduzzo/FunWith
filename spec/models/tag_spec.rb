RSpec.describe Tag, type: :model do

  describe 'validations' do

    let ( :valid_tag_params ) do
      {
        label: "kayak",
        description: "descriptfull description",
      }
    end

    context "when label field is empty" do
      
      let( :invalid_tag_params ) { valid_tag_params.except( :label ) }
      
      it 'data invalid' do
        tag = Tag.new( invalid_tag_params )
        expect( tag.valid? ).to be false
      end
    end

    context "when description field is empty" do
      
      let( :invalid_tag_params ) { valid_tag_params.except( :description ) }
      
      it 'data invalid' do
        tag = Tag.new( invalid_tag_params )
        expect( tag.valid? ).to be false
      end
    end
  end
end
