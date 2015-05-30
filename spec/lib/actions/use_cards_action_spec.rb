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

  end

end