module Risk::Game 

  describe TurnStartState do 
    before :each do
      @state = TurnStartState.new
    end

    describe ".allows?" do
      it "returns true for PlaceAction" do 
        action = PlaceAction.new(1, :kamchatka, 4)
        expect(@state.allows? action).to be true
      end

      it "returns true for UseCardAction" do
        action = UseCardsAction.new(1,["Alaska"])
        expect(@state.allows? action).to be true
      end

      it "returns true for all other actions" do 
        action = NoMoveAction.new
        expect(@state.allows? action).to be false
      end
    
    end

  end

end