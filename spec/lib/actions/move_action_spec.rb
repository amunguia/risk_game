module Risk::Game

  describe MoveAction do

    before :each do
      @move_action = MoveAction.new(:alaska, :kamchatka, 3)
    end

    describe ".destination_country" do 
      it "returns the correct destination country" do 
        expect(@move_action.destination_country).to eq :kamchatka
      end
    end

    describe ".number_armies" do 
      it "returns the correct destination country" do 
        expect(@move_action.number_armies).to eq 3
      end
    end

    describe ".reset" do 
      it "sets the minimum_move on the game to 0" do   
        game = Game.new
        game.minimum_move = 2
        @move_action.reset game
        expect(game.minimum_move).to be 0
      end

      it "returns the game" do 
        game = Game.new
        expect(@move_action.reset game).to eq game
      end
    end

    describe ".source_country" do 
      it "returns the correct destination country" do 
        expect(@move_action.source_country).to eq :alaska
      end
    end

    describe ".valid_on?" do 

      before :each do 
        @game = Game.new
        allow(@game).to receive(:armies_in).with(:alaska).and_return(10)
        allow(@game).to receive(:minimum_move).and_return(3)
        allow(@game).to receive(:owner_of).with(:alaska).and_return(1)
        allow(@game).to receive(:owner_of).with(:kamchatka).and_return(1)
      end

      context "is valid" do 
        it "returns true" do 
          expect(@move_action.valid_on? @game).to be true
        end
      end

      context "is invalid" do 

        it "returns false if countries are not adjacent" do 
          action = MoveAction.new(:alaska, :argentina, 3)
          expect(action.valid_on? @game).to be false
        end

        it "returns false if number_armes is greater than number in source country - 1" do 
          action = MoveAction.new(:alaska, :kamchatka, 10)
          expect(action.valid_on? @game).to be false
        end

        it "returns false if number_armies is less than mininimum" do
          action = MoveAction.new(:alaska, :kamchatka, 1)
          expect(action.valid_on? @game).to be false
        end

        it "returns false if the owner is the not same for both countries" do 
          allow(@game).to receive(:owner_of).with(:kamchatka).and_return(2)
          expect(@move_action.valid_on? @game).to be false
        end

      end

    end

  end 

end