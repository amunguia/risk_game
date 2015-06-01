module Risk::Game

  describe MoveAfterWinAction do 
    before :each do 
        @game = Game.new
        allow(@game).to receive(:armies_in).with(:alaska).and_return(10)
        allow(@game).to receive(:minimum_move).and_return(3)
        allow(@game).to receive(:owner_of).with(:alaska).and_return(1)
        allow(@game).to receive(:owner_of).with(:kamchatka).and_return(1)

        @move_action = MoveAfterWinAction.new(:alaska, :kamchatka, 3)
      end

    describe ".valid_on?" do 
      it "returns false if source_country is not the same as move_from" do 
        @game.move_from = :alberta
        expect(@move_action.valid_on? @game).to be false
      end
    end

    describe ".valid_on?" do 
      it "returns false if source_country is not the same as move_from" do 
        @game.move_to = :alberta
        expect(@move_action.valid_on? @game).to be false
      end
    end

  end

end