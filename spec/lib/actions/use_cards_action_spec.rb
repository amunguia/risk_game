module Risk::Game

  describe UseCardsAction do 

    before :each do 
      @use_cards_action = UseCardsAction.new(1,[5,2])
    end

    describe ".by_user" do 
      it "returns the user using cards" do 
        expect(@use_cards_action.by_user).to eq 1
      end
    end

    describe ".cards_to_use" do 
      it "returns an array of card ids to be used" do
        expect(@use_cards_action.cards_to_use).to eq [5,2]
      end
    end

    describe ".valid_on?" do 
      before :each do 
        @game = Game.new
        allow(@game).to receive(:cards_for_player).with(1).and_return([1,2,5,8,9])
      end

      context "is valid" do 
        it "returns true" do 
          expect(@use_cards_action.valid_on? @game).to be true
        end
      end

      context "is invalid" do 
      
        it "returns false if the user does not own all the cards" do 
          allow(@game).to receive(:cards_for_player).with(1).and_return([1,5,8,9])
          expect(@use_cards_action.valid_on? @game).to be false
        end

      end

    end

  end

end