module Risk::Game

  describe UseCardsAction do 

    before :each do 
      @use_cards_action = UseCardsAction.new(1,["Alaska","Alberta"])
    end

    describe ".by_user" do 
      it "returns the user using cards" do 
        expect(@use_cards_action.by_user).to eq 1
      end
    end

    describe ".cards_to_use" do 
      it "returns an array of card ids to be used" do
        expect(@use_cards_action.cards_to_use).to eq ["Alaska","Alberta"]
      end
    end

    describe ".execute_on" do
      before :each do 
        @game = Game.new
        allow(@game).to receive(:cards_for_player).with(1).and_return(["Alaska","Alberta", "Congo", "Siam", "Yakutsk"])
      end

      it "increases the max_place by the value from the cards" do 
        max_place = @game.max_place
        @use_cards_action.execute_on(@game)
        expect(@game.max_place).to be (max_place + 2)
      end

      it "removes the cards from the cards_for_player list" do 
        @use_cards_action.execute_on(@game)
        expect(@game.cards_for_player(1)).to eq ["Congo", "Siam", "Yakutsk"]
      end
    end


    describe ".valid_on?" do 
      before :each do 
        @game = Game.new
        allow(@game).to receive(:cards_for_player).with(1).and_return(["Alaska","Argentina", "Alberta"])
      end

      context "is valid" do 
        it "returns true" do 
          expect(@use_cards_action.valid_on? @game).to be true
        end
      end

      context "is invalid" do 
      
        it "returns false if the user does not own all the cards" do 
          allow(@game).to receive(:cards_for_player).with(1).and_return(["Alaska", "Argentina"])
          expect(@use_cards_action.valid_on? @game).to be false
        end

      end

    end

  end

end