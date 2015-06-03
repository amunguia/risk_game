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

    describe ".update" do 

      before :each do 
        @game = Game.create_with_players [1,2,3]
        @game.max_place = 10
      end
     
      context "player has placed all armies" do 

        it "returns an AttackState" do 
          @game.max_place = 0
          @action = PlaceAction.new(1,:alaska, 10)
          expect(@state.update(@action, @game)).to be_kind_of(AttackState)
        end

      end

      context "player still has armies to place" do 

        it "returns a TurnStartState" do 
          @action = PlaceAction.new(1, :alaska, 10)
          expect(@state.update(@action, @game)).to be_kind_of(TurnStartState)
        end

      end

      context "player turns in cards" do  

        it "returns a TurnStartAfterCardsState" do 
          @action = UseCardsAction.new(1, ["Alaska", "Ontario"])
          expect(@state.update(@action, @game)).to be_kind_of(TurnStartAfterCardsState)
        end
        
      end

    end

  end

end