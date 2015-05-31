module Risk::Game

    describe NoMoveAction do 

      describe ".valid_on?" do 
        it "returns true" do 
          action = NoMoveAction.new
          expect(action.valid_on?(Game.new)).to be true
        end
      end

    end

end