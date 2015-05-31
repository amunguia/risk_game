module Risk::Game

    describe NoMoveAction do 

      describe ".execute_on" do 
        it "returns true" do 
          action = NoMoveAction.new
          expect(action.execute_on(Game.new)).to be true
        end
      end

      describe ".valid_on?" do 
        it "returns true" do 
          action = NoMoveAction.new
          expect(action.valid_on?(Game.new)).to be true
        end
      end

    end

end