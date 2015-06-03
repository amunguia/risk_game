module Risk::Game

  describe TurnStartAfterCardsState do 

    before :each do 
      @state = TurnStartAfterCardsState.new
    end

    describe ".allows?" do 

      it "returns true for PlaceACtion" do
        action = PlaceAction.new(1, :kamchatka, 4)
        expect(@state.allows? action).to be true
      end

      it "returns false for any other action" do 
        action = NoMoveAction.new
        expect(@state.allows? action).to be false
      end
      
    end

  end

end