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
        game = Game.create_with_players [1,2,3,4]
        starting_count = game.armies_in(:alaska)
        @place_action.execute_on game
        expect(game.armies_in(:alaska)).to be (starting_count + 5)
      end

      it "decreases the number of max_place by number placed" do 
        game = Game.create_with_players [1,2,3,4]
        starting_place = game.max_place
        @place_action.execute_on game
        expect(game.max_place).to be (starting_place - 5)
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

        it "sets error_message when the user does not own the country" do 
          allow(@game).to receive(:owner_of).with(:alaska).and_return(2)
          @place_action.valid_on? @game
          expect(@place_action.error_message).to eq "Sorry, you cannot place armies into another players country."
        end

        it "returns false if the number_armies is greater than max place" do 
          allow(@game).to receive(:max_place).and_return(2)
          expect(@place_action.valid_on? @game).to be false
        end

        it "sets error_message when the user places too many armies in the country" do 
          allow(@game).to receive(:max_place).and_return(2)
          @place_action.valid_on? @game
          expect(@place_action.error_message).to eq "Sorry, you are placing too many armies."
        end

      end

    end

  end

end