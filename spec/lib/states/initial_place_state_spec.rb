module Risk::Game

  describe InitialPlaceState do 
    before :each do 
      @state = InitialPlaceState.new
    end

    describe ".allows?" do 
      it "returns true to PlaceAction" do
        action = PlaceAction.new(1, :kamchatka, 4)
        expect(@state.allows? action).to be true
      end

      it "returns false to any other action" do 
        action = NoMoveAction.new
        expect(@state.allows? action).to be false
      end
    end

  end

end