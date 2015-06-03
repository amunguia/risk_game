module Risk::Game

  describe Cards do 
  
    describe ".card_list" do 

      it "returns an array of card ids" do 
        expect(Cards.card_list).to be_kind_of(Array)
      end

      it "returns an array of length 42" do 
       expect(Cards.card_list.length).to be 42
      end

    end

    describe ".card_value" do 

      it "raises an error if the card does not exist" do 
        expect{ Cards.card_value "Fake Card" }.to raise_error(NotACard)
      end

      it "returns teh card value if it exists" do 
        expect(Cards.card_value "Alaska").to be 1
      end

    end

    describe ".is_a_card?" do 

      it "returns true if the card name passed in is a card" do 
        expect(Cards.is_a_card? "Alaska").to be true
      end

      it "returns false if the card name passed in is not a card" do 
        expect(Cards.is_a_card? "Fake Card").to be false
      end
      
    end

  end

end