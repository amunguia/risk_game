module Risk::Game

    describe NoMoveAction do 

      describe ".execute_on" do 

        it "returns value" do 
          action = NoMoveAction.new
          expect(action.execute_on(Game.new)).to_not be nil
        end
      
      end
      
    end

end