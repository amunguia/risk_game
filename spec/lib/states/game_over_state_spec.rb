module Risk::Game

  describe  GameOverState do 

    before :each do 
      @state = GameOverState.new
    end

    describe ".allows?" do 

      it "returns false for any action" do 
        action = Action.new
        expect(@state.allows? action).to be false
      end

    end

    describe ".valid_on?" do 

      it "returns false for any game" do 
        game = Game.create_with_players [1,2,3,4]
        expect(@state.allows? game).to be false
      end

    end

  end

end