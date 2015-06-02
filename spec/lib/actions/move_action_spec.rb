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

    describe ".execute_on" do 
      before :each do 
        @game = Game.new
      end

      it "increases the number of armies in the destination country" do 
        starting_count = @game.armies_in :kamchatka
        @move_action.execute_on(@game)
        expect(@game.armies_in :kamchatka).to eq (starting_count + 3)
      end

      it "decreases the number of armies in the source country" do 
        starting_count = @game.armies_in :alaska
        @move_action.execute_on(@game)
        expect(@game.armies_in :alaska).to eq (starting_count - 3)
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

        it "sets error message if countries are not adjacent" do 
          action = MoveAction.new(:alaska, :argentina, 3)
          action.valid_on? @game
          expect(action.error_message).to eq "Countries are not adjacent."
        end

        it "returns false if number_armes is greater than number in source country - 1" do 
          action = MoveAction.new(:alaska, :kamchatka, 10)
          expect(action.valid_on? @game).to be false
        end

        it "sets error message whe number_armies is greater than nubmer in source country - 1" do 
          action = MoveAction.new(:alaska, :kamchatka, 10)
          action.valid_on? @game
          expect(action.error_message).to eq "Number of armies is greater than 9"
        end

        it "returns false if number_armies is less than mininimum" do
          action = MoveAction.new(:alaska, :kamchatka, 1)
          expect(action.valid_on? @game).to be false
        end

        it "sets error_message if number_armies is less than minimum" do 
          action = MoveAction.new(:alaska, :kamchatka, 1)
          action.valid_on? @game
          expect(action.error_message).to eq "Number of armies is less than 3."
        end

        it "returns false if the owner is the not same for both countries" do 
          allow(@game).to receive(:owner_of).with(:kamchatka).and_return(2)
          expect(@move_action.valid_on? @game).to be false
        end

        it "sets error_message if the owner is not the same for both countries" do 
          allow(@game).to receive(:owner_of).with(:kamchatka).and_return(2)
          @move_action.valid_on? @game
          expect(@move_action.error_message).to eq "You do not own both countries."
        end

      end

    end

  end 

end