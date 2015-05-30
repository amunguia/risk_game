module Risk::Game

  describe MoveAction do

    before :each do
      @move_action = MoveAction.new(:alaska, :kamchatka, 3)
    end

    describe ".destination_country" do 
      it "returns the correct destination country" do 
        expect(@move_action.destination_country).to eq :kamchatka
      end
    end

    describe ".number_armies" do 
      it "returns the correct destination country" do 
        expect(@move_action.number_armies).to eq 3
      end
    end

    describe ".source_country" do 
      it "returns the correct destination country" do 
        expect(@move_action.source_country).to eq :alaska
      end
    end

  end 

end