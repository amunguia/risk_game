module Risk::Game

  describe PlaceAction do 

    before :each do 
      @place_action = PlaceAction.new(1,:alaska, 5)
    end

    describe ".by_user" do 
      it "returns the user placing armies" do 
        expect(@place_action.by_user).to be 1
      end
    end

    describe ".destination_country" do
      it "returns the destination country" do 
        expect(@place_action.destination_country).to be :alaska
      end
    end

    describe ".number_armies" do 
      it "returns the correct number of armies to place" do 
        expect(@place_action.number_armies).to be 5
      end
    end

    describe ".execute_on" do 
      it "increases the number of armies in the country being placed into" do 
        game = Game.new
        starting_count = game.armies_in(:alaska)
        @place_action.execute_on(game)
        expect(game.armies_in(:alaska)).to be (starting_count + 5)
      end
    end

    describe ".reset" do
      
      it "sets max_place on the game to 0" do 
        game = Game.new
        game.max_place = 5
        @place_action.reset game
        expect(game.max_place).to be 0
      end

      it "returns the game" do 
        game = Game.new
        expect(@place_action.reset game).to be game
      end
    end

    describe ".valid_on?" do 
      before :each do 
        @game = Game.new
        allow(@game).to receive(:owner_of).with(:alaska).and_return(1)
        allow(@game).to receive(:max_place).and_return(10)
      end

      context "is valid" do
        it "returns true" do 
          expect(@place_action.valid_on? @game).to be true
        end
      end

      context "is invalid" do 
        
        it "returns false if the user does not own the country" do 
          allow(@game).to receive(:owner_of).with(:alaska).and_return(2)
          expect(@place_action.valid_on? @game).to be false
        end

        it "returns false if the number_armies is greater than max place" do 
          allow(@game).to receive(:max_place).and_return(2)
          expect(@place_action.valid_on? @game).to be false
        end

      end

    end

  end

end