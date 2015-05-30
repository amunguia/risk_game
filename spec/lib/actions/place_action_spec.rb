module Risk::Game

  describe PlaceAction do 

    before :each do 
      @place_action = PlaceAction.new(1,5)
    end

    describe ".by_user" do 
      it "returns the user placing armies" do 
        expect(@place_action.by_user).to eq 1
      end
    end

    describe ".number_armies" do 
      it "returns the correct number of armies to place" do 
        expect(@place_action.number_armies).to eq 5
      end
    end

  end

end